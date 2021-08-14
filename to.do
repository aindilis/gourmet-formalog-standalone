(try to integrate this:
 https://www.efsa.europa.eu/en/data-report/chemical-hazards-database-openfoodtox)

(https://data.europa.eu/data/datasets)

(#!/bin/sh

docker build --rm  .
# docker run -e "USER=andrewdo" -e "GROUP=andrewdo" -e "USER_ID=1000" -e "GROUP_ID=1000" .

# docker run --rm -v "$(pwd):/$pwd | slugify)" -w "/$(pwd | slugify)" -ti --entrypoint=aindilis-gourmet-formalog-standalone

# docker run --rm -ti --entrypoint= aindilis-gourmet-formalog-standalone-2146d58a:1.0 bash)


;; this might help to guide some of it, but it's not ready yet.  Have
;; to fix Prolog-WordNet loading.

(docker run -it <IMAGE>)
(docker ps)
(docker container exec -it <CONTAINER> bash)
(su andrewdo -c bash)
(cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog && swipl -s gourmet.pl -t prolog)
(ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_logic.pl').)
(ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_specialty_diets.pl').)
(ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_fodmap.pl').)
(search_food_data_central('611269716467',Res).)
(findall(X,schema(X),Ys), write_list(Ys).)


;; (--env "USER=$USER" --env "GROUP=$USER" --env "USER_ID=1000" --env "GROUP_ID=1000")

(https://recipe-data.com/en/)

(https://allenai.org/data/propara)

(example broken recipe:
 http://localhost:4000/frdcsa/codebases/internal/gourmet/recipe/Beef%20Chow%20Fun)

(low energy -> if I had adequate nutrition I would have better
 energy, and also I wouldn't be hungry as much if I had enough
 protein in my diet.  find out diet so I can work on stuff and be
 healthy)

(https://foodkg.github.io/kbqa.html)

(
2020-01-04 19:26:58 <aindilis> is there anything out there for querying a set
      of facts stored in SWIPL mem using SQL sytnax?
2020-01-04 19:28:29 <oni-on-ion> https://github.com/salva/plswipl   =P
2020-01-04 19:28:56 <oni-on-ion> or
      https://stackoverflow.com/questions/724377/prolog-to-sql-converter  ?
2020-01-04 19:35:23 *** python476
)

(2020-01-06 19:22:22 <sseehh> a substitution and restriction graph would
 resemble route planning. like some vehicles cant travel on certain roads
 some people cant eat certain food but may be able to reach a destination
 (ingredient) through a detour
 )

(get a system going for pengines to provide a client server
 between different formalogs. look at the stuff in ld44 to test)

(use isub to do levenshtein
 https://www.swi-prolog.org/pldoc/man?predicate=isub/4)

(possibly use my apt processing tool to process ingredient names down)

(use dcgs to parse the ingredients)


(2020-01-07 19:25:37 <aindilis> hey folks, I am currently using YASWI to
      communicate with SWIPL from Perl.  I run a findall query to grab all
      results, but it usually takes at least a second per query.  I was
      wondering about writing a Pengines client in Perl?  Any particular
      advice regarding this?
2020-01-07 19:25:40 *** oni-on-ion (~oni-on-io@2001:1970:57e0:4100::e513) has
      quit: Ping timeout: 248 seconds
2020-01-07 19:27:02 <aindilis> Oh, I should note I already have code for
      parsing Prolog from Perl into an Interlingua e.g. a(b([c,d],E)) would be
      ['a',['b',['_prolog_list','c','d'],\*{'?E'}]]
2020-01-07 19:28:21 <aindilis> Regarding Pengines client in Perl - is there
      anything SWIPL side that would prevent this?  I imagine it's just an
      HTTP-based protocol.
2020-01-07 19:31:33 <aindilis> Another Pengines-based question I have is, I
      have N SWIPL processes, and I want them to be able to query them.
      Currently I'm using SWIPL-(YASWI)->Perl->UniLang->Perl-(YASWI)->SWIPL.
      Does Pengines have a facilitator system for a hub-spoke model or would
      it be better to connect all the pengines to each other, I cannot imagine
      the latter is preferred. 
2020-01-07 19:32:13 <aindilis> And if no facilitator exists, would there be
      interest in me developing one.)


