#! /bin/bash

DB=phonebook.db

function clear() {
  [ -e "$DB" ] && rm "$DB"
}

function list() {
  if [ -s "$DB" ]; then
    cat "$DB"
  else
    echo Phonebook is empty
  fi
}

function new() {
  echo $* >>"$DB"
}

function remove() {
  [ -s "$DB" ] && sed -i.original "/$*/d" "$DB"
}

function search() {
  [ -s "$DB" ] && grep "$*" "$DB"  
}

case $1 in
  clear) clear  ;;
  list)  list   ;;
  new)   shift; new $* ;;
  remove) shift; remove $* ;;
  *)     shift; search $* ;;
esac
