#!/bin/bash
# todo_functions.sh - Soubor s funkcemi pro to-do list

# Soubor pro ukládání úkolů
TODO_FILE="$HOME/.SeznamUkolu.txt"

# Vytvoření souboru, pokud neexistuje
touch "$TODO_FILE"

# Funkce pro zobrazení menu
show_menu() {
    echo ""
    echo "________________________________"
    echo "      TO-DO LIST MANAGER"
    echo "________________________________"
    echo "1) Přidat úkol"
    echo "2) Zobrazit všechny úkoly"
    echo "3) Označit úkol jako hotový"
    echo "4) Smazat úkol"
    echo "5) Vymazat všechny úkoly"
    echo "6) Ukončení"
    echo "________________________________"
}

# Funkce pro přidání úkolu
add_task() {
    echo -n "Zadej nový úkol: "
    read task
    if [ -n "$task" ]; then
        echo "[ ] $task" >> "$TODO_FILE"
        echo "✓ Úkol přidán!"
    else
        echo "✗ Úkol nemůže být prázdný!"
    fi
}

# Funkce pro zobrazení úkolů
show_tasks() {
    if [ ! -s "$TODO_FILE" ]; then
        echo "Seznam úkolů je prázdný."
        return
    fi
    
    echo ""
    echo "Tvoje úkoly:"
    echo "------------"
    nl -w2 -s'. ' "$TODO_FILE"
}

# Funkce pro označení úkolu jako hotového
complete_task() {
    show_tasks
    if [ ! -s "$TODO_FILE" ]; then
        return
    fi
    
    echo -n "Zadej číslo úkolu k označení jako hotový: "
    read task_num
    
    if [[ "$task_num" =~ ^[0-9]+$ ]]; then
        total_lines=$(wc -l < "$TODO_FILE")
        if [ "$task_num" -ge 1 ] && [ "$task_num" -le "$total_lines" ]; then
            sed -i "${task_num}s/\[ \]/[✓]/" "$TODO_FILE"
            echo "✓ Úkol označen jako hotový!"
        else
            echo "✗ Neplatné číslo úkolu!"
        fi
    else
        echo "✗ Zadej platné číslo!"
    fi
}

# Funkce pro smazání úkolu
delete_task() {
    show_tasks
    if [ ! -s "$TODO_FILE" ]; then
        return
    fi
    
    echo -n "Zadej číslo úkolu ke smazání: "
    read task_num
    
    if [[ "$task_num" =~ ^[0-9]+$ ]]; then
        total_lines=$(wc -l < "$TODO_FILE")
        if [ "$task_num" -ge 1 ] && [ "$task_num" -le "$total_lines" ]; then
            sed -i "${task_num}d" "$TODO_FILE"
            echo "✓ Úkol smazán!"
        else
            echo "✗ Neplatné číslo úkolu!"
        fi
    else
        echo "✗ Zadej platné číslo!"
    fi
}

# Funkce pro vymazání všech úkolů
clear_all() {
    echo -n "Opravdu chceš smazat všechny úkoly? (a/n): "
    read confirm
    if [ "$confirm" = "a" ] || [ "$confirm" = "A" ]; then
        > "$TODO_FILE"
        echo "✓ Všechny úkoly smazány!"
    else
        echo "Operace zrušena."
    fi
}
