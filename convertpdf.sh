#!/bin/bash

echo "Конвертируем Markdown в PDF..."

./convert.sh

if command -v wkhtmltopdf &> /dev/null; then
    echo "Используем wkhtmltopdf..."
    wkhtmltopdf otchet.html otchet.pdf
elif command -v libreoffice &> /dev/null; then
    echo "Используем LibreOffice..."
    libreoffice --convert-to pdf otchet.html
else
    echo "Установленных конвертеров не найдено."
    echo ""
    echo "ИНСТРУКЦИЯ ДЛЯ РУЧНОЙ КОНВЕРТАЦИИ:"
    echo "1. Откройте файл в браузере:"
    echo "   xdg-open otchet.html"
    echo "2. Нажмите Ctrl+P"
    echo "3. Выберите 'Сохранить как PDF'"
    echo "4. Сохраните как otchet.pdf"
    echo ""
    echo "Или установите конвертер:"
    echo "sudo apt install wkhtmltopdf"
fi

if [ -f "otchet.pdf" ]; then
    echo "PDF отчёт создан: otchet.pdf"
    echo "Для просмотра: xdg-open otchet.pdf"
fi
