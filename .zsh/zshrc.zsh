# load lib
zlibs=(
  aliases
)

# Function if order matters
for zshfile in $zlibs; do
  . "${ZDOTDIR}/${zshfile}"
done
unset zshfile
