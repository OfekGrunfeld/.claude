#!/usr/bin/env bash
# Claude Code statusline — dir + git + ctx + rate limits + model

ESC=$'\033'
R="${ESC}[0m"
DIM="${ESC}[2m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
BOLD="${ESC}[1m"

input=$(cat)

cwd=$(echo "$input"         | jq -r '.workspace.current_dir // .cwd // empty')
model_id=$(echo "$input"    | jq -r '.model.id // empty')
model_name=$(echo "$input"  | jq -r '.model.display_name // empty')
used=$(echo "$input"        | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input"    | jq -r '.context_window.context_window_size // empty')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
worktree=$(echo "$input"    | jq -r '.workspace.git_worktree // empty')
rate_5h=$(echo "$input"     | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_7d=$(echo "$input"     | jq -r '.rate_limits.seven_day.used_percentage // empty')

# --- Directory (~ substitution) ---
short_dir="${cwd/#$HOME/\~}"

# --- Project prefix (only when project_dir != cwd) ---
project_prefix=""
if [ -n "$project_dir" ] && [ "$project_dir" != "null" ] && [ "$project_dir" != "$cwd" ]; then
  pname=$(basename "$project_dir")
  project_prefix="${BOLD}${BLUE}${pname}${R} "
fi

# --- Git: branch + dirty ---
git_info=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.fsmonitor= symbolic-ref --short HEAD 2>/dev/null \
         || git -C "$cwd" -c core.fsmonitor= rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$cwd" -c core.fsmonitor= status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [ -n "$branch" ]; then
    if [ "$dirty" -gt 0 ]; then
      git_info=" ${YELLOW}${branch} *${R}"
    else
      git_info=" ${GREEN}${branch}${R}"
    fi
  fi
fi
if [ -n "$worktree" ] && [ "$worktree" != "null" ]; then
  git_info="${git_info}${DIM}[wt]${R}"
fi

# --- Context window ---
ctx_info=""
if [ -n "$used" ] && [ "$used" != "null" ]; then
  used_int=$(printf "%.0f" "$used")
  ctx_k=""
  if [ -n "$ctx_size" ] && [ "$ctx_size" != "null" ]; then
    ctx_k="/$(echo "$ctx_size" | awk '{printf "%dk", $1/1000}')"
  fi
  if [ "$used_int" -ge 85 ]; then
    ctx_info=" ${RED}ctx:${used_int}%${ctx_k}${R}"
  elif [ "$used_int" -ge 60 ]; then
    ctx_info=" ${YELLOW}ctx:${used_int}%${ctx_k}${R}"
  else
    ctx_info=" ${CYAN}ctx:${used_int}%${ctx_k}${R}"
  fi
fi

# --- Rate limits (only show when non-trivial) ---
rate_info=""
if [ -n "$rate_5h" ] && [ "$rate_5h" != "null" ]; then
  r5=$(printf "%.0f" "$rate_5h")
  if [ "$r5" -ge 80 ]; then
    rate_info="${rate_info} ${RED}5h:${r5}%${R}"
  elif [ "$r5" -ge 40 ]; then
    rate_info="${rate_info} ${YELLOW}5h:${r5}%${R}"
  fi
fi
if [ -n "$rate_7d" ] && [ "$rate_7d" != "null" ]; then
  r7=$(printf "%.0f" "$rate_7d")
  if [ "$r7" -ge 80 ]; then
    rate_info="${rate_info} ${RED}7d:${r7}%${R}"
  elif [ "$r7" -ge 40 ]; then
    rate_info="${rate_info} ${YELLOW}7d:${r7}%${R}"
  fi
fi

# --- Model (shorten id: claude-sonnet-4-6-20251022 → sonnet-4-6) ---
model_info=""
if [ -n "$model_id" ] && [ "$model_id" != "null" ]; then
  short=$(echo "$model_id" | sed 's/^claude-//; s/-[0-9]\{8\}$//')
  model_info=" ${MAGENTA}${short}${R}"
elif [ -n "$model_name" ] && [ "$model_name" != "null" ]; then
  model_info=" ${MAGENTA}${model_name}${R}"
fi

# --- Caveman mode ---
caveman_info=""
caveman_file="/tmp/claude_caveman_mode"
if [ -f "$caveman_file" ]; then
  caveman_level=$(cat "$caveman_file" 2>/dev/null)
  if [ -n "$caveman_level" ]; then
    caveman_info=" ${BOLD}${RED}🗿${caveman_level}${R}"
  fi
fi

printf "%s${BLUE}%s${R}%s%s%s%s%s\n" \
  "$project_prefix" "$short_dir" "$git_info" "$ctx_info" "$rate_info" "$model_info" "$caveman_info"
