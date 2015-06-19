#!/bin/bash
make clean
make

for num in `seq 1 1 10`
do
    ./standard_mpc -p <(find ./feature_test/feature"$num"*) feature"$num"_correct.parse
    ./mpc -p <(find ./feature_test/feature"$num"*) feature"$num"_me.parse

    if result="$(diff <(find feature"$num"_correct.parse) <(find feature"$num"_me.parse))"
    then
       echo "Feature"$num" passed"
    else
       echo "Feature"$num" did not passed"
       echo "$result"
    fi
done
