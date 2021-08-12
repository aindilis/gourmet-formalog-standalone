Note it will take a long time to generate the qlfs for FDC data.

```
git clone https://github.com/aindilis/gourmet-formalog-standalone
cd gourmet-formalog-standalone
docker build .
docker images
docker run -it <IMAGE> bash
./run.sh
```

Then try input like this:

```
findall(X,schema(X),Ys), write_list(Ys).
search_food_data_central('611269716467',Res).

```
