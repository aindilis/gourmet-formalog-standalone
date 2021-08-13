Please install using docker.  Note that this Docker build is having
some issues, but is otherwise somewhat ready to use.

Note it will take a long time to generate the qlfs for FDC
data. 

```
git clone https://github.com/aindilis/gourmet-formalog-standalone
cd gourmet-formalog-standalone
docker build .
docker images
docker run -it <IMAGE> bash
./run.sh
```

Please note that it might fail to build food_nutrient.qlf and possibly
some others, in which case: try this:

```
docker container ps -a
docker container exec -it <CONTAINER> bash
cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/USDA-Food-DB/ && swipl -g "qcompile('food_nutrient.pl')."
cd /home/andrewdo && ./run.sh
```

If all is working, try input like this:

```
findall(X,schema(X),Xs),write_list(Xs).
```

```
search_food_data_central('611269716467',Res),write_list(Res).

```
