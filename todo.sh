#!/bin/bash
# todo.sh - Hlavní script pro to-do list

# Najdi cestu ke skriptu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Načti funkce
source "$SCRIPT_DIR/todo_functions.sh"

# Hlavní smyčka programu
while true; do
    show_menu
    echo -n "Vyber možnost (1-6): "
    read choice
    
    case $choice in
        1)
            add_task
            ;;
        2)
            show_tasks
            ;;
        3)
            complete_task
            ;;
        4)
            delete_task
            ;;
        5)
            clear_all
            ;;
        6)
            echo "Nashledanou!"
            exit 0
            ;;
        *)
            echo "✗ Neplatná volba! Vyber číslo 1-6."
            ;;
    esac
    
    echo ""
    echo -n "Stiskni ENTER pro pokračování..."
    read
done
