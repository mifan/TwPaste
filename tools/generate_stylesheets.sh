styles='monokai manni perldoc borland colorful default murphy vs trac tango fruity autumn bw emacs pastie friendly native'
style_file_name='pygments.css'
echo '' > $style_file_name
for loop in $styles
do
  echo "processing $loop ..."
  `pygmentize -f html -S $loop -a .hl$loop >> $style_file_name`
done

