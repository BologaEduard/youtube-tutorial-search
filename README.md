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
    *   Először frissítsd a csomaglistát:
        ```
        sudo apt update
        ```
    *   Majd telepítsd a `jq`-t és a `curl`-t:
        ```
        sudo apt install jq curl
        ```
        (a disztribúciótól függően)
4.  Állítsd be az API kulcsot a `.env` fájlban:
    *   Először hozd létre a `.env` fájlt: `touch .env`
    *   Majd szerkeszd a fájlt egy szövegszerkesztővel (pl. `nano .env`): `nano .env`
    *   Illeszd be a következő sort, és cseréld ki a `YOUR_API_KEY`-t a saját API kulcsodra:
        ```
        YOUTUBE_API_KEY=YOUR_API_KEY
        ```
    *   Mentsd el a fájlt.
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
