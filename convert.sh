#!/bin/bash

echo "Начин конвертацию отчёта"

echo "<!DOCTYPE html>
<html>
<head>
    <meta charset=\"UTF-8\">
    <title>Отчёт</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; line-height: 1.6; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        h2 { color: #34495e; margin-top: 25px; }
        strong { color: #e74c3c; }
        ul { padding-left: 20px; }
        li { margin: 8px 0; }
        .date { background: #3498db; color: white; padding: 8px 15px; border-radius: 5px; display: inline-block; margin: 10px 0; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class=\"container\">" > otchet.html

while IFS= read -r line; do
    line=$(echo "$line" | sed "s/\$(date +\"%d.%m.%Y\")/$(date +"%d.%m.%Y")/g")
    
    case "$line" in
        "# "*)
            echo "<h1>${line#* }</h1>" >> otchet.html
            ;;
        "## "*)
            echo "<h2>${line#* }</h2>" >> otchet.html
            ;;
        "- "*)
            echo "<ul>" >> otchet.html
            content=$(echo "${line#* }" | sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g')
            echo "<li>$content</li>" >> otchet.html
            echo "</ul>" >> otchet.html
            ;;
        ""*"")
            content=$(echo "$line" | sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g')
            echo "<p>$content</p>" >> otchet.html
            ;;
        *)
            if [[ ! -z "$line" ]]; then
                echo "<p>$line</p>" >> otchet.html
            fi
            ;;
    esac
done < otchet.md

echo "    </div>
</body>
</html>" >> otchet.html

echo "HTML отчёт создан: otchet.html"
cho "Дата отчета: $(date +"%d.%m.%Y")"
