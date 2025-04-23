#!/bin/bash
set -e

# ==============================================================================
# YouTube tutorial kereső szkript - 2. feladat
# Készítette: Bologa Eduard - DAM4AV
# Dátum: 2024-04-25
#
# Leírás:
# Ez a szkript a YouTube API-t használva ChatGPT-vel kapcsolatos
# scripting vagy coding tutorialokat keres.
# A leglátogatottabb 50 videó linkjét és címét kiírja egy CSV fájlba.
#
# Használat:
# 1. Állítsd be a YOUTUBE_API_KEY változót a .env fájlban.
# 2. Futtasd a szkriptet: ./youtube_fetch.sh
#
# Kimenet: videos.csv fájl, tabulátorral elválasztott URL-ekkel és címekkel.
# ==============================================================================

# API kulcs betöltése
if [ ! -f .env ]; then
  echo "Hiba: .env fájl nem található!" >&2
  exit 1
fi
source .env

# Lekérdezési paraméterek
QUERY="chatgpt coding tutorial"
MAX_RESULTS=50
OUTPUT_FILE="videos.csv"

# VideoID-k lekérése
VIDEO_IDS=$(curl -s "https://www.googleapis.com/youtube/v3/search?part=id&type=video&maxResults=$MAX_RESULTS&q=${QUERY// /%20}&key=$YOUTUBE_API_KEY" \
| jq -r '.items[].id.videoId' | paste -sd ",")

# CSV fejléc
echo -e "URL\tTitle" > "$OUTPUT_FILE"

# Adatok lekérése, nézettség szerinti kiírás
curl -s "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=$VIDEO_IDS&key=$YOUTUBE_API_KEY" \
| jq -r '.items | sort_by(-(.statistics.viewCount | tonumber))[] |
    "https://www.youtube.com/watch?v=" + .id + "\t" +
    (.snippet.title | gsub("\n"; " ")) + "\t" +
    (.statistics.viewCount // "0")' \
>> "$OUTPUT_FILE"

echo "Mentve: $OUTPUT_FILE"

# ==============================================================================
# Tesztek
# ==============================================================================

# 1. Ellenőrzi, hogy az API kulcs be van-e állítva
if [ -z "$YOUTUBE_API_KEY" ]; then
  echo "TESZT HIBA: YOUTUBE_API_KEY nincs beállítva!" >&2
  exit 1
fi

# 2. Ellenőrzi, hogy a kimeneti fájl létrejött-e
if [ ! -f "$OUTPUT_FILE" ]; then
  echo "TESZT HIBA: $OUTPUT_FILE nem jött létre!" >&2
  exit 1
fi

# 3. Ellenőrzi, hogy a kimeneti fájl nem üres
FILE_SIZE=$(stat -c %s "$OUTPUT_FILE")
if [ "$FILE_SIZE" -eq 0 ]; then
  echo "TESZT HIBA: $OUTPUT_FILE üres!" >&2
  exit 1
fi

# 4. API teszt (ellenőrzi, hogy a válasz érvényes JSON)
API_TEST=$(curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=1&q=test&key=$YOUTUBE_API_KEY")
if ! echo "$API_TEST" | jq . > /dev/null 2>&1; then
  echo "TESZT HIBA: Érvénytelen JSON válasz az API-tól!" >&2
  exit 1
fi

echo "TESZTEK SIKERESEN LEFUTOTTAK!"
