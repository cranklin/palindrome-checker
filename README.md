# palindrome-checker

This is my solution (written in Assembly) to a sample interview question that is given to candidates interviewing at Brand Networks

Assemble instructions:

nasm -f elf palincheck2.asm
ld -m elf_i386 -s -o palincheck2 palincheck2.o
./palincheck2
