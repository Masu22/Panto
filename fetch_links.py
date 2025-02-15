import requests
from bs4 import BeautifulSoup

URL = "http://pantodon.jp/index.rb?body=index"
OUTPUT_FILE = "links.txt"

try:
    response = requests.get(URL, timeout=10)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")
    links = [a["href"] for a in soup.find_all("a", href=True)]

    # 既存のリンクを読み込む
    try:
        with open(OUTPUT_FILE, "r", encoding="utf-8") as f:
            existing_links = set(f.read().splitlines())
    except FileNotFoundError:
        existing_links = set()

    # 新しいリンクを追加
    new_links = set(links) - existing_links

    if new_links:
        with open(OUTPUT_FILE, "a", encoding="utf-8") as f:
            for link in new_links:
                f.write(link + "\n")
        print(f"{len(new_links)} 個の新しいリンクを追加しました。")
    else:
        print("新しいリンクはありません。")

except requests.exceptions.RequestException as e:
    print(f"エラー: {e}")
