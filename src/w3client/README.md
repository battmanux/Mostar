# Client www 

## html

Les widgets qui se retrouvent dans l'application web.
 
  - il sont appelés par la fonction mostar_load_tmpl("XXX") ou XXX est le 
nom de de base du fichier (sans l'extention). Cette fonction appelle whisker.render en passant tous les templates comme partial et les data associés à la page.
 
  - les templates sont interprétés en {{mustach}}.
 
  - mostar-click-data="xxx" permet de déclancher l'action clique avec xxx comme paramètre  
  
  
## js

Le code javascript chargé de base à loouverture de session

  - main.js sera appelé par défaut

## style

LE style CSS appliqué au dessus de bootstrap. 

  - main.css sera appelé par défaut