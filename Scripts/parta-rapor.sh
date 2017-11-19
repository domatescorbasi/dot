#!/bin/bash

# Config variablelari bunlar.
reportdir="/home/hztrance/Workspace/Parta/rapor"
editor="subl3"

# Bu variablelar constant
week=$(date '+%V')
month=$(date '+%m-%B')
year=$(date '+%Y')
timestamp=$(date '+%Y-%m-%d')

case "$1" in
    --daily-report | --gunluk-rapor | -dr | dr | -gr | gr)
        DAY=$(date '+%u-%A')
        mkdir -p "$reportdir/$year/$month/Week-$week/"
        "$editor" "$reportdir/$year/$month/Week-$week/Daily-Report-$DAY-$timestamp.txt"
        if [[ -n $(which notify-send) ]]; then
            notify-send " Gunluk raporunu yaz."
        fi
        ;;
    --week-summery | --hafta-ozeti | -sw | sw | -ho | ho )
        mkdir -p "$reportdir/$year/$month/Week-$week/"
        "$editor" "$reportdir/$year/$month/Week-$week/$week-th-Week-Summary-$timestamp.txt"
        if [[ -n $(which notify-send) ]]; then
            notify-send " Hafta ozetini yaz."
        fi
        ;;
    --next-week-plan | --gelecek-hafta-plani | -nwp | nwp | -ghp | ghp )
        weeknumber="$(bc <<< "$week + 1")"
        mkdir -p "$reportdir/$year/$month/Week-$weeknumber/"
        "$editor" "$reportdir/$year/$month/Week-$weeknumber/$weeknumber-th-Week-Plan-$timestamp.txt"
        if [[ -n $(which notify-send) ]]; then
            notify-send " Gelecek haftanin planini yaz."
        fi
        ;;
    --week-plan | --hafta-plani | -wp | wp | -hp | hp )
        weekplan=$(grep -lr "Plan" "$reportdir/$year/$month/Week-$week/")
        "$editor" "$weekplan"
        if [[ -n $(which notify-send) ]]; then
            notify-send " Bu haftanin plani incelenmek uzere acildi."
        fi
        ;;
    *)
        echo "$0 Help."
        echo "[*] Description:  This script eases initializations for parta reports."
        echo "[*] Usage         : $0 [OPTION]"
        echo ""
        echo "[*] Options:        --gunluk-rapor, -gr, gr    --daily-report, -dr, dr"
        # echo "                    Gunluk raporu kategorize sekilde yazmak icin hazirlar."
        echo "                    Generates daily report in a structured folder."
        echo ""
        echo "                    --hafta-ozeti, -ho, ho    --week-summery, -sw, sw"
        # echo "                    Haftalik raporu kategorize sekilde yazmak icin hazirlar."
        echo "                    Generates this weeks summary report in a structured folder."
        echo ""
        echo "                    --gelecek-hafta-plani, -ghp, ghp    --next-week-plan, -nwp, nwp"
        # echo "                    Gelecek hafta raporunu alakali klasore yazmak icin hazirlar."
        echo "                    Generates next weeks work plan in a structured folder."
        echo ""
        echo "                    --hafta-plani, -hp, hp    --week-plan, -wp, wp"
        # echo "                    Bu haftanin planini editoruzle goruntulemek icin acar."
        echo "                    Displays this weeks week plan in the editor."
        exit 1
esac

exit 0
