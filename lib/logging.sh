#!/usr/bin/env bash

# Logging utility using gum with Monokai Pro Filter Spectrum colors

# shellcheck disable=SC1091
source "lib/colors.sh"

function info() {
  gum log --level=info --time=short --format=false \
    --level.foreground="$INFO_COLOR" "$*"
}

function debug() {
  gum log --level debug --time short --format=true \
    --level.foreground "$DEBUG_COLOR" "$*"
}

function warn() {
  gum log --level warn --time short --format=true \
    --level.foreground "$WARN_COLOR" "$*"
}

function error() {
  gum log --level error --time short --format=true \
    --level.foreground "$ERROR_COLOR" "$*"
}

function log() {
  case "$1" in
    info)
      shift
      info "$*"
      ;;
    debug)
      shift
      debug "$*"
      ;;
    warn)
      shift
      warn "$*"
      ;;
    error)
      shift
      error "$*"
      ;;
    *)
      error "Unknown log level: $1"
      return 1
      ;;
  esac
}

function help() {
  info "This is an info message"
  debug "This is a debug message"
  warn "This is a warning message"
  error "This is an error message"
}
