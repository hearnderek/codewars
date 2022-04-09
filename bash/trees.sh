# Input is piped in
# Maximum value of 5
read n

# Output MUST be a be a grid of 63x100
y=63
x=100
splits="49"
steps=16
splitStepsRemaining=0
stepsUntilSplit=$steps
state=vert
for (( i=0; i < y; i+=1 ))
do
  # A simple state machine to manipulate $splits
  case $state in
    (vert) {  
      if [[ $stepsUntilSplit == 0 ]]
      then
        state=split
        splitStepsRemaining=$(( $steps - 1 )) 
        newSplits=""
        for split in $splits
        do
            newSplits+=" $(( $split-1 ))"
            newSplits+=" $(( $split+1 ))"
        done
        splits="$newSplits"
      else
        stepsUntilSplit=$(( $stepsUntilSplit - 1 ))
      fi
    } ;;
    
    (split) {
      if [[ $splitStepsRemaining == 0 ]]
      then
        n=$(( $n - 1 ))
        if [[ $n == 0 ]]
        then
          # This matches against nothing
          state=end
          splits=""
        else
          state=vert
          steps=$(( $steps / 2 ))
          stepsUntilSplit=$(( $steps - 1 ))
        fi

      else
        splitStepsRemaining=$(( $splitStepsRemaining - 1 ))
        j=1
        newSplits=""
        for split in $splits
        do
          jmod2=$(( $j % 2 ))
          if [[ $jmod2 == 1 ]]
          then
            newSplits+=" $(( $split - 1 ))"
          else
            newSplits+=" $(( $split + 1 ))"
          fi
          j=$(( $j + 1 )) 
        done
        splits="$newSplits"
      fi
    } ;;
  esac

  # turn $splits into a line of text
  line=""
  for (( j=0; j < x; j+=1 ))
  do
    found="false"
    for split in $splits
    do
      if [[ $split == $j ]]
      then
        found="true"
      fi
    done

    if [[ $found == "true" ]]
    then
      line+="1"
    else
      line+="_"
    fi
  done

  # Output the line
  echo $line
  # Since the above code generates the tree in the wrong direction,
  # a piping to tac reverses everything to pass the tests.
done | tac
