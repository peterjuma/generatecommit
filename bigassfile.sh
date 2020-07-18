#!/bin/bash
rand=$(awk 'BEGIN{srand();print int(rand()*(63000-2000))+2000 }')
text="Cras varius. Etiam sollicitudin, ipsum eu pulvinar rutrum, tellus ipsum laoreet sapien, quis venenatis ante odio sit amet eros. Fusce pharetra convallis urna."
yes $text | head -n 100000 > bigassfile${rand}.txt
