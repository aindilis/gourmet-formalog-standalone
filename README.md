DO NOT USE YET, STILL WORKING ON DOCKERFILE INSTALLATION

DO NOT USE YET, STILL WORKING ON DOCKERFILE INSTALLATION

DO NOT USE YET, STILL WORKING ON DOCKERFILE INSTALLATION

DO NOT USE YET, STILL WORKING ON DOCKERFILE INSTALLATION

DO NOT USE YET, STILL WORKING ON DOCKERFILE INSTALLATION

---

That said:

Still have to fix Prolog WordNet loading, and many other things.

Note it will take a long time to generate the qlfs for FDC data, and
some FDC tables are not loading yet, have to investigate.

NOTE THIS IS NOT A SCRIPT:


```
docker build .
docker images
docker run -it <IMAGE>
docker ps
docker container exec -it <CONTAINER> bash
su andrewdo -c bash
cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog && swipl -s gourmet.pl -t prolog
# ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_logic.pl').
# ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_specialty_diets.pl').
# ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_fodmap.pl').
# search_food_data_central('611269716467',Res).
# findall(X,schema(X),Ys), write_list(Ys).
```
