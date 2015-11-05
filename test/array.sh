# Advanced Bash :: Array slicing and compaction in bash

# TL;DR

X=(something 'whatever' "i have more   S  P  A  C  E  S   than i can give away.  arent you jealous?")

#   ${X[@]}                                        the usual whole array
#   ${X[@]:index:length}                           slice from index to index+length-1 inclusive
#   ${X[@]::length}                                slice from 0 to length-1 inclusive
#   ${X[@]:index}                                  slice from index to end of array inclusive
#   X=( "${X[@]}" )                                compact X
#   X=( "${X[@]::$INDEX}" "${X[@]:$((INDEX+1))}" ) remove element at INDEX and compact array

# Examples:

Y=(000 111 222 333)

join(){
  local IFS="/"
  echo "$*"
}

echo 'slice 1 2 3'
join 1 2 3

echo '${Y[@]:2}'
join "${Y[@]:2}"
# 222 333

echo "${Y[@]:1:3}"
# 111 222 333

echo "${Y[@]::1}"
# 000

INDEX=2

# this wont work in some situations
unset Y[$INDEX]
echo "${Y[@]}"
# 000 111 333
echo "${#Y[@]}"
# 3            # looks correct, but it's not
echo "${Y[3]}"
# 333          # you might be thinking: '???'
               # this is because bash arrays are sparse, like a NoSQL

echo "${#Y[@]}"
# 3
Y[9999]=9999
echo "${#Y[@]}"
# 4
# see?

# when dealing with arrays that are compact (no unset elements) AT LEAST UNTIL INDEX+1,
# this will remove the element at INDEX
Y=( "${Y[@]::$INDEX}" "${Y[@]:$((INDEX+1))}" )
echo "${Y[@]}"
# 000 111 333 9999
echo "${Y[3]}"
# 9999

# so you just want a sparse array to be compact right now?
Y=( 000 111 222 333 )
Y[9999]=9999
echo "${Y[@]}"
# 000 111 222 333 9999
echo "${Y[9999]}"
# 9999

Y=( "${Y[@]}" ) # compact

echo "${Y[@]}"
# 000 111 222 333 9999
echo "${Y[4]}"
# 9999

# fin.