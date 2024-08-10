# 🍽️ Gourmet-Formalog-Standalone: Your AI-Powered Meal Planning Companion 🍳

[![Docker Build Status](https://img.shields.io/docker/build/aindilis/gourmet-formalog-standalone)](https://hub.docker.com/r/aindilis/gourmet-formalog-standalone)
[![GitHub License](https://img.shields.io/github/license/aindilis/gourmet-formalog-standalone)](https://github.com/aindilis/gourmet-formalog-standalone/blob/main/LICENSE)

## 🌟 Introduction

Welcome to Gourmet-Formalog-Standalone, a powerful, open-source meal planner that puts you in control of your nutrition! 🥗 Built on a robust Prolog backend, Gourmet-Formalog-Standalone integrates a wealth of food-related data to help you create personalized, healthy meal plans tailored to your unique needs and preferences. 🍎

Gourmet-Formalog-Standalone is part of the Free Life Planner (FLP) project, which aims to create a free, open-source AI system to help people manage various aspects of daily life. The meal planner aims to improve nutrition, taste, cost, and convenience for individuals and families. 

## 🚀 Features

- 📊 Comprehensive food databases, including Food Data Central, Open Food Toxicity DB, SOAR Recipe Archive, Prolog WordNet, and FODMAP DB
- ⚡ Lightning-fast data loading using the Quick Load Format (QLF)  
- 🍳 Intelligent meal planning algorithms tailored to your preferences and health needs
- 🖥️ Intuitive web interface for scanning barcodes, viewing nutrition info, and more
- 🌐 Accessible via various Pengines libraries from multiple languages
- 🔍 Powerful food ontology with knowledge of substitutions, properties, and similarities
- 🧪 Integration with health data to support specialized diets (GERD, diabetes, etc)
- 🤝 Community ownership via free/libre/open-source license (GPL)

## 💡 Philosophy & Motivation

As free software that can be copied and redistributed at near-zero cost, Gourmet-Formalog-Standalone and the FLP have the potential to help alleviate hunger, disease, and other problems at a global scale. By packaging a comprehensive set of AI capabilities into an integrated system and releasing it under a free software license, we aim to create a universal tool that can adapt to serve the needs of people worldwide.

Some key philosophical and technical points behind the project:

- Separate software components can be integrated to create more powerful systems
- Free software is non-rivalrous and can be copied endlessly to benefit more people
- Modeling reality symbolically and reasoning over digital twins can help manage real-world complexity
- Releasing under a free/libre/open-source license (GPL) enables community ownership, adaptability, and broad distribution to help the most people

## 🔧 Getting Started

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

## 🛣️ Roadmap

### Completed ✅

- Barcode scanning and nutrition lookup for 100,000s of products 
- Rapid loading of comprehensive food, recipe, and nutrition databases
- Temporal metric planning for nutritionally tailored meal plans
- Interactive cooking assistant to walk through recipes step-by-step

### In Progress 🚧 

- Support for specialized medical diets (diabetes, GERD, etc)
- Comprehensive food ontology with knowledge of substitutions and properties 
- Natural language recipe parsing and normalization
- Recommender system for recipes and ingredients based on preferences

### Planned 📅

- Multi-user meal planning that factors in schedules, transport, budgets
- Modeling of food spoilage, inventory, and shopping needs
- Detailed nutrition tracking and empirical analysis 
- Integration with telemedicine, symptom tracking, and health records

## 🌍 Join Us in Ending Information Poverty

The broader vision of the FLP is to end the "information dark ages" where critical knowledge doesn't reach the people who need it in time. Whether it's knowing which foods are safe for a medical condition or having step-by-step guidance in an emergency, we believe AI can democratize access to life-saving information and planning abilities.

Gourmet-Formalog-Standalone is one component of this mission, focused on the universal need for healthy, affordable, and tailored nutrition. By modeling each individual's situation, integrating diverse data sources, and generating optimized plans, we hope this libre meal planner can help improve health outcomes for people worldwide.

We welcome contributors to join us in realizing this vision! As a free/libre/open-source project, Gourmet-Formalog-Standalone will always remain community-owned and adaptable to local needs. Financial support can also help accelerate development. Together we can build AI that empowers people everywhere to live better.

## 🙏 Acknowledgements 

We would like to thank all the contributors and open-source projects that have made Gourmet-Formalog-Standalone possible, including the developers of the various food databases and libraries we rely on.

## 📄 License

Gourmet-Formalog-Standalone is proudly released under the [GNU General Public License v3.0](https://github.com/aindilis/gourmet-formalog-standalone/blob/main/LICENSE) as free/libre/open-source software.

---

🍽️ Here's to healthy eating for everyone with the power of AI! 🥦🥑🍗🍚🥕
