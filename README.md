```
git clone https://github.com/aindilis/gourmet-formalog-standalone
cd gourmet-formalog-standalone
docker build .
docker images
docker run -it <IMAGE> bash
./run.sh
```

Note it will take a long time to generate the qlfs for FDC data, and
some FDC tables are not loading yet, have to investigate.

```
findall(X,schema(X),Ys), write_list(Ys).
search_food_data_central('611269716467',Res).

```
