#!/bin/bash
rand=$(awk 'BEGIN{srand();print int(rand()*(63000-2000))+2000 }')

text="Phasellus a est. Quisque libero metus, condimentum nec, tempor a, commodo mollis, magna. Praesent metus tellus, elementum eu, semper a, adipiscing nec, purus. Praesent turpis. Quisque id mi.\n
Nam pretium turpis et arcu. Praesent congue erat at massa. Fusce neque. Nam at tortor in tellus interdum sagittis. Nulla consequat massa quis enim.\n
Aliquam erat volutpat. Aenean viverra rhoncus pede. Nam at tortor in tellus interdum sagittis. Nulla consequat massa quis enim.\n
Praesent ut ligula non mi varius sagittis.

Phasellus consectetuer vestibulum elit.\n

Etiam feugiat lorem non metus.\n"

yes $text | head -n 1100000 > bigassfile${rand}.txt
