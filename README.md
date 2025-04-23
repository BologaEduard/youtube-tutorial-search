# YouTube Tutorial Kereső Szkript

Ez a szkript a YouTube API-t használva ChatGPT-vel kapcsolatos scripting vagy coding tutorialokat keres. A leglátogatottabb 50 videó linkjét és címét kiírja egy CSV fájlba.

## Használat

1.  Klónozd a repót:
    ```
    git clone https://github.com/BologaEduard/youtube-tutorial-search.git
    ```
2.  Navigálj a mappába:
    ```
    cd youtube_script
    ```
3.  Telepítsd a függőségeket:
    ```
    sudo apt-get install jq
    ```
    vagy
    ```
    sudo yum install jq
    ```
    (a disztribúciótól függően)
4.  Állítsd be az API kulcsot a `.env` fájlban:
    *   Készíts egy `.env` fájlt a következő tartalommal:
        ```
        YOUTUBE_API_KEY=YOUR_API_KEY
        ```
    *   Cseréld ki a `YOUR_API_KEY`-t a saját YouTube Data API v3 kulcsodra.
5.  Futtasd a szkriptet:
    ```
    ./youtube_fetch.sh
    ```

## Függőségek

*   [jq](https://stedolan.github.io/jq/): Parancssori JSON processzor. Szükséges a YouTube API válaszának feldolgozásához.

    *   Telepítés: `sudo apt-get install jq` vagy `sudo yum install jq`
    *   Megbízhatóság: A `jq` egy széles körben használt és megbízható eszköz, aktív fejlesztéssel és nagy felhasználói táborral.

## Tesztek

A szkript végén található tesztek ellenőrzik, hogy:

*   Az API kulcs be van-e állítva.
*   A kimeneti fájl létrejött-e.
*   A kimeneti fájl nem üres.
*   Az API válasz érvényes JSON.

A tesztek automatikusan lefutnak a szkript végén. Ha bármelyik teszt sikertelen, a szkript hibát jelez.

## Megjegyzés

A szkript a YouTube Data API v3-at használja. Győződj meg róla, hogy engedélyezted az API-t a Google Cloud Console-ban, és beállítottad a megfelelő kvótákat.
