#!/usr/bin/env bash

NERD_FONT_FREE="󱁕"
NERD_FONT_MEETING="󰤙"

INCLUDE_CAL="ranveer.kumar@travenues.com"

NEXT_MEETING="$(
  icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "title,datetime" \
    --noCalendarNames \
    --dateFormat "%-I:%M %p" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    --includeCals "$INCLUDE_CAL" \
    eventsToday 2>/dev/null
)"

if [[ -z "$NEXT_MEETING" ]]; then
  echo "$NERD_FONT_FREE"
  exit 0
fi

# Normalize Unicode spaces from icalBuddy/macOS.
NORMALIZED="$(printf '%s\n' "$NEXT_MEETING" | perl -CS -pe 's/\x{202F}/ /g; s/\x{00A0}/ /g')"

TITLE="$(printf '%s\n' "$NORMALIZED" \
  | grep -vE '^[[:space:]]*$|^[[:space:]]*today:|^-+$|[0-9]{1,2}:[0-9]{2}' \
  | head -n 1 \
  | sed 's/^[[:space:]]*//' \
  | sed 's/[[:space:]]*([^)]*)$//')"

TIMES="$(printf '%s\n' "$NORMALIZED" \
  | grep -Eo '[0-9]{1,2}:[0-9]{2} *(AM|PM|am|pm)' \
  | head -n 2)"

START_TIME="$(printf '%s\n' "$TIMES" | sed -n '1p')"
END_TIME="$(printf '%s\n' "$TIMES" | sed -n '2p')"

if [[ -z "$TITLE" || -z "$START_TIME" ]]; then
  echo "$NERD_FONT_FREE"
  exit 0
fi

TODAY="$(date "+%Y-%m-%d")"
START_EPOCH="$(date -j -f "%Y-%m-%d %I:%M %p" "$TODAY $START_TIME" "+%s" 2>/dev/null)"

if [[ -z "$START_EPOCH" ]]; then
  echo "$NERD_FONT_FREE"
  exit 0
fi

NOW_EPOCH="$(date "+%s")"
DIFF_SECONDS=$((START_EPOCH - NOW_EPOCH))
DIFF_MINUTES=$(((DIFF_SECONDS + 59) / 60))

if (( DIFF_SECONDS < 0 )) && [[ -n "$END_TIME" ]]; then
  END_EPOCH="$(date -j -f "%Y-%m-%d %I:%M %p" "$TODAY $END_TIME" "+%s" 2>/dev/null)"

  if [[ -n "$END_EPOCH" ]] && (( END_EPOCH < START_EPOCH )); then
    END_EPOCH=$((END_EPOCH + 86400))
  fi

  if [[ -n "$END_EPOCH" ]] && (( NOW_EPOCH <= END_EPOCH )); then
    ENDS_IN_MINUTES=$(((END_EPOCH - NOW_EPOCH + 59) / 60))
    SHORT_TITLE="$(printf '%s' "$TITLE" | cut -c1-30)"
    echo "$NERD_FONT_MEETING now $SHORT_TITLE (${ENDS_IN_MINUTES}m)"
    exit 0
  fi
fi

if (( DIFF_SECONDS < 0 )); then
  echo "$NERD_FONT_FREE"
  exit 0
fi

SHORT_TITLE="$(printf '%s' "$TITLE" | cut -c1-30)"

echo "$NERD_FONT_MEETING $START_TIME $SHORT_TITLE (${DIFF_MINUTES}m)"
