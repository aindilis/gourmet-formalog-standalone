# 🍽️ Gourmet-Formalog-Standalone: Your AI-Powered Meal Planning Companion 🍳

[![Docker Build Status](https://img.shields.io/docker/build/aindilis/gourmet-formalog-standalone)](https://hub.docker.com/r/aindilis/gourmet-formalog-standalone)
[![GitHub License](https://img.shields.io/github/license/aindilis/gourmet-formalog-standalone)](https://github.com/aindilis/gourmet-formalog-standalone/blob/main/LICENSE)

Welcome to Gourmet-Formalog-Standalone, the powerful, open-source meal planner that puts you in control of your nutrition! 🥗 Built on a robust Prolog backend, Gourmet-Formalog-Standalone integrates a wealth of food-related data to help you create personalized, healthy meal plans tailored to your unique needs and preferences. 🍎

## 🌟 Features

- 📊 Comprehensive food databases, including Food Data Central, Open Food Toxicity DB, SOAR Recipe Archive, Prolog WordNet, and FODMAP DB
- ⚡ Lightning-fast data loading using the Quick Load Format (QLF)
- 🧩 Seamless integration with the Free Life Planner (FLP) for holistic nutrition management
- 🍳 Intelligent meal planning algorithms (coming soon!)
- 🖥️ Intuitive user interface (in development)
- 🌐 Accessible via various Pengines libraries from multiple languages

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) installed on your system

### Installation

1. Clone the Gourmet-Formalog-Standalone repository:

```bash
git clone https://github.com/aindilis/gourmet-formalog-standalone.git
cd gourmet-formalog-standalone
```

2. Build the Docker image:

```bash
docker build .
```

3. Run the Docker container:

```bash
docker images
docker run -it <IMAGE> bash
```

4. Inside the container, start Gourmet-Formalog-Standalone:

```bash
./run.sh
```

### Troubleshooting

If the build fails due to issues with `food_nutrient.qlf` or other files, try the following:

1. Find the running Gourmet-Formalog container:

```bash
docker ps -a
docker container exec -it <CONTAINER> bash
```

If there are no running containers, start a new one:

```bash
docker images
docker run -it <IMAGE> bash
```

2. Inside the container, compile the problematic files and update permissions:

```bash
cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/food-data-central/ && swipl -g "qcompile('food_nutrient.pl')."
chown andrewdo.andrewdo /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/food-data-central/food_nutrient.qlf
```

3. Restart Gourmet-Formalog-Standalone:

```bash
cd /home/andrewdo && ./run.sh
```

## 🎨 Usage Examples

Once Gourmet-Formalog-Standalone is running, you can interact with it using Prolog queries. Here are a few examples:

- List all available schemas:
  ```prolog
  findall(X,schema(X),Xs),write_list(Xs).
  ```

- Search for a specific food item in the Food Data Central database:
  ```prolog
  search_food_data_central('611269716467',Res),write_list(Res).
  ```

- Count the number of recipes in the database:
  ```prolog
  findall(1,rec(_,_,_),Recs),length(Recs,Len),write_list([Len]).
  ```

- Test the food data parsing functionality:
  ```prolog
  testParseFooddata.
  ```

## 🌍 Pengines Support

Gourmet-Formalog-Standalone supports pengines on port 9883, allowing you to interact with the system using various clients, such as:

- [Pengines Documentation](https://pengines.swi-prolog.org/docs/documentation.html)
- [Python Pengines Client](https://pypi.org/project/pengines/)
- [Java Pengines Client](https://github.com/simularity/JavaPengine)
- [Formalog Pengines Client](https://github.com/aindilis/formalog-pengines)

To query the pengines server, follow these steps:

1. Inside the Docker container, navigate to the formalog-pengines directory:

```bash
cd /var/lib/myfrdcsa/codebases/minor/formalog-pengines/formalog_pengines/ && swipl -s formalog_pengines_client.pl
```

2. Load the ports configuration:

```prolog
consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/ports.pl').
```

3. Enter a query, for example:

```prolog
query_formalog_pengines_agent(gourmet,'172.17.0.2',search_food_data_central('611269716467',Res),Result),print_term(Result,[]).
```

## 📚 Additional Resources

For more information on meal planning and related resources, please visit:

- [Meal Planning Resources](https://frdcsa.org/~andrewdo/WebWiki/MealPlanningResources.html)
- [Food Ontology](https://frdcsa.org/~andrewdo/WebWiki/FoodOntology.html)
- [Cooking Assistant](https://frdcsa.org/~andrewdo/WebWiki/CookingAssistant.html)
- [Recipe Recommendation System](https://frdcsa.org/~andrewdo/WebWiki/RecipeRecommendationSystem.html)

## 🤝 Contributing

We welcome contributions from the community! If you'd like to help improve Gourmet-Formalog-Standalone, please feel free to submit pull requests, report issues, or share your ideas for new features.

## 📄 License

Gourmet-Formalog-Standalone is released under the [GNU General Public License v3.0](https://github.com/aindilis/gourmet-formalog-standalone/blob/main/LICENSE).

## 🙏 Acknowledgements

We would like to thank all the contributors and open-source projects that have made Gourmet-Formalog-Standalone possible, including the developers of the various food databases and libraries we rely on.

---

🍽️ Happy meal planning with Gourmet-Formalog-Standalone! 🥦�🍗🥑
