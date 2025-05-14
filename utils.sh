# utils.sh
print_success() {
  local GREEN="\033[0;32m"
  local NC="\033[0m"
  echo -e "${GREEN}$1${NC}"
}

print_error() {
  local RED="\033[0;31m"
  local NC="\033[0m"
  echo -e "${RED}$1${NC}"
}
