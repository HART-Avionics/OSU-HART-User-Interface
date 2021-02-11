#!/bin/bash

clear # Clear screen

# While user input is empty
while [ -z "$pname" ]; do
  # Get project name
  echo -e "\nProject Name (OSU HART New Project):"
  read pname
done

# Convert project name to PascalCase
pname_pascal_case=$(echo $pname | sed -r 's/(^|\s)(\w)/\U\2/g')

# Convert project name to lowercase-hyphen-delineated
pname_lowercase=${pname,,}
pname_hyphens=${pname_lowercase//[ ]/-}

# While user input is empty
while [ -z "$pdescs" ]; do
  # Get short project description
  echo -e "\nShort Project Description (Rocket reaction control system):"
  read pdescs
done

# Get long project description
echo -e "\n[Optional] Long Project Description (The goal of this project is to X for Y so that Z.):"
read pdescl

# If user didn't input a long description
if [ ! -n "$pdescl" ]; then
  pdescl=$pdescs # Then use short decription in its place
fi

# Find & replace instances of '<#PROJECT#>' with hyphenated project name
# i.e. 'osu-hart-new-project'
find . \
  \( -type d -name .git -prune \
  -o -type f -name setup.sh -prune \) \
  -o -type f -print0 | xargs -0 sed -i \
  "s/<#PROJECT#>/$pname_hyphens/g"

# Find & replace instances of '<#PROJECT TITLE#>' with project name
# i.e. 'OSU HART New Project'
find . \
  \( -type d -name .git -prune \
  -o -type f -name setup.sh -prune \) \
  -o -type f -print0 | xargs -0 sed -i \
  "s/<#PROJECT TITLE#>/$pname/g"

# Find & replace instances of '<#SHORT PROJECT DESCRIPTION#>' with short project description
# i.e. 'Rocket reaction control system'
find . \
  \( -type d -name .git -prune \
  -o -type f -name setup.sh -prune \) \
  -o -type f -print0 | xargs -0 sed -i \
  "s/<#SHORT PROJECT DESCRIPTION#>/$pdescs/g"

# Find & replace instances of '<#LONG PROJECT DESCRIPTION#>' with long project description
# i.e. 'The goal of this project is to X for Y so that Z.'
find . \
  \( -type d -name .git -prune \
  -o -type f -name setup.sh -prune \) \
  -o -type f -print0 | xargs -0 sed -i \
  "s/<#LONG PROJECT DESCRIPTION#>/$pdescl/g"
