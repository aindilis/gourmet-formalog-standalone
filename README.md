god-mode on your food.

This is the backend to a very powerful open source meal planner called
Gourmet (written in Prolog).  It essentially fuses together tons of
information from various databases.  Currently the (unreleased) Free
Life Planner is able to query Gourmet to build its nutrition facts,
and then compute meal plans.

This program includes lots of large datasets, including Food Data
Central, Open Food Toxicity DB, SOAR Recipe Archive, Prolog WordNet,
and FODMAP DB.  They are all compiled to the very quick loading "QLF"
format, and load almost instantly.  But it is memory intensive.

Going to continue adding datasets and then writing helper
functionality to access and interrelate them, such as the
gourmet-logic.pl file:

https://github.com/aindilis/gourmet-formalog-standalone/blob/main/scripts/gourmet/gourmet_logic.pl

Is able to be queried from various Pengines libraries from a variety
of languages.

---

Please install using Docker.  Note that this Docker build is having
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
docker ps -a
docker container exec -it <CONTAINER> bash
```

Or if there are no running Gourmet-Formalog containers, then:

```
docker images
docker run -it <IMAGE> bash
```

Then:

```
cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/food-data-central/ && swipl -g "qcompile('food_nutrient.pl')."
chown andrewdo.andrewdo /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/food-data-central/food_nutrient.qlf
cd /home/andrewdo && ./run.sh
```

If all is working, try input like this:

```
findall(X,schema(X),Xs),write_list(Xs).

search_food_data_central('611269716467',Res),write_list(Res).

findall(1,rec(_,_,_),Recs),length(Recs,Len),write_list([Len]).

testParseFooddata.

```

"Puts the filling in fulfilling"

Added support for pengines on port 9883.  You can talk to pengines
using a number of clients such as
https://pengines.swi-prolog.org/docs/documentation.html or
https://pypi.org/project/pengines/ or
https://github.com/simularity/JavaPengine or
https://github.com/aindilis/formalog-pengines etc.


Note pengines will open the 9883 port on the Docker container, to query you must do something like this:

```
cd /var/lib/myfrdcsa/codebases/minor/formalog-pengines/formalog_pengines/ && swipl -s formalog_pengines_client.pl
```

then:

```
consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/ports.pl').
```

Then you must enter a query, eg:

```
query_formalog_pengines_agent(gourmet,'172.17.0.2',search_food_data_central('611269716467',Res),Result),print_term(Result,[]).
```

---

For more information see:

https://frdcsa.org/~andrewdo/WebWiki/MealPlanningResources.html
