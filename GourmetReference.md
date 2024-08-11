# Gourmet Reference Manual

## Under Construction

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [System Architecture](#system-architecture)
4. [User Interface](#user-interface)
5. [Meal Planning](#meal-planning)
6. [Recipe Management](#recipe-management)
7. [Inventory Management](#inventory-management)
8. [Nutrition Analysis](#nutrition-analysis)
9. [Shopping and Ordering](#shopping-and-ordering)
10. [Special Diets and Restrictions](#special-diets-and-restrictions)
11. [AI and Machine Learning](#ai-and-machine-learning)
12. [Data Sources and Integration](#data-sources-and-integration)
13. [Privacy and Security](#privacy-and-security)
14. [Customization and Extensibility](#customization-and-extensibility)
15. [Troubleshooting](#troubleshooting)
16. [Future Work](#future-work)
17. [Contributing](#contributing)
18. [License](#license)

## 1. Introduction

### Purpose
Gourmet is an AI-powered meal planning system designed to optimize nutrition, reduce costs, and simplify meal preparation for individuals and families. It aims to democratize access to advanced nutritional planning tools and promote healthier eating habits.

### User Base
- Individuals seeking to improve their diet
- Families looking to streamline meal planning and preparation
- People with specific dietary needs or restrictions
- Budget-conscious consumers
- Anyone interested in exploring new recipes and cuisines

### Sample Use Cases
- Generate a week's worth of balanced, budget-friendly meals
- Plan meals around specific health goals (e.g., weight loss, muscle gain)
- Accommodate multiple dietary restrictions within a household
- Optimize grocery shopping to reduce food waste
- Learn new cooking techniques and explore diverse cuisines

### Status
Gourmet is actively developed as part of the Free Life Planner (FLP) project. While many core features are operational, development is ongoing to expand capabilities and improve user experience.

## 2. Features

### Completed Features
- ✅ Comprehensive food databases integration (Food Data Central, Nutritionix, SOAR Recipe Archive)
- ✅ Barcode scanning for quick product information lookup
- ✅ Basic meal plan generation based on nutritional requirements
- ✅ PGourmet system
- ✅ Door sensor alerts on fridge and freezer for portion control
- ✅ Integration with WordNet and OpenCyc for food ontology

### In Progress Features
- [ ] <code>[66%]</code> PDDL-based meal planner
- [ ] <code>[50%]</code> Gourmet-Formalog-Standalone system
- [ ] <code>[50%]</code> Interactive cooking assistant
- [ ] <code>[40%]</code> Seamless integration with FLP's generalized action planning systems
- [ ] <code>[40%]</code> Self-discipline coach software
- [ ] <code>[33%]</code> Food ontology development
- [ ] <code>[25%]</code> Interactive cooking assistant
- [ ] <code>[20%]</code> Logging and planning of macros
- [ ] <code>[20%]</code> Follow-up dialog regarding intent when fridge and freezer accessed

### Planned Features
- Meal plan optimization for long-term health outcomes
- Collaborative meal planning for households and groups
- Integration with personal health data for tailored nutrition advice
- Seasonal and local food prioritization
- Freezer cooking support
- Advanced food safety management
- Emergency food and water provision management

## 3. System Architecture

Gourmet is built on a modular architecture that allows for easy expansion and integration with other systems. Key components include:

- Core Planning Engine: Prolog-based PDDL planner for meal plan generation
- Data Layer: Manages interactions with various food and recipe databases
- User Interface: Web-based frontend for user interactions
- AI Module: Handles machine learning tasks for personalization and recipe analysis
- Integration Layer: Manages connections with external services (e.g., grocery stores, FLP modules)

### Meal Planning Resources
- Multiple meal planning and preparation systems
- Gourmet-Formalog-Standalone (using OpenFoodTox, Basket)
- PDDL-based meal planner
- Interactive cooking assistant
- PGourmet
- Gourmet
- st0opkid's MealSolver

## 4. User Interface

### Web Interface
- Responsive design for desktop and mobile use
- Dashboard with meal plan overview, shopping lists, and quick actions
- Recipe browser with filtering and search capabilities
- Inventory management interface
- Settings and preference configuration

### Mobile App
- 🚧 Native mobile app for iOS and Android (in development)
- Barcode scanning functionality
- Quick meal logging and inventory updates
- Shopping list management

### Voice Assistant Integration
- [ ] <code>[50%]</code> Basic Alexa skill and Rhasspy interface for querying meal plans and adding items to shopping list
- [ ] <code>[25%]</code> Enhanced voice interactions for hands-free cooking assistance

## 5. Meal Planning

### Plan Generation
- [ ] <code>[66%]</code> PDDL-based meal planner for comprehensive meal contingent plan generation
- [ ] <code>[40%]</code> Seamless integration with FLP's generalized action planning systems
- [ ] <code>[20%]</code> Consideration of leftover ingredients and batch cooking opportunities

### Customization
- [ ] <code>[50%]</code> Fine-tuning of nutritional targets and preferences
- Food style and preference learning
- Estimating when users might tire of specific recipes or ingredients

### Optimization
- ✅ Basic cost optimization
- Freezer cooking support (reduces cost and prep time by ≥4X)
- 🚧 Advanced multi-objective optimization (nutrition, cost, preparation time, variety)

### Nutrition Lookup
- ✅ Using FDC CSVs converted to Prolog KB (Food Data Central)
- ✅ Using Nutritionix (working but offline due to air-gapping development server)

## 6. Recipe Management

### Recipe Database
- ✅ Integration of 300,000+ recipes (150,000 from SOAR Recipe Archive, additional 150,000 planned)
- 🚧 User ability to add custom recipes
- [ ] <code>[10%]</code> Automatic nutritional analysis of custom recipes

### Recipe Recommendations
- 🚧 Recommender system / collaborative filtering over recipes, ingredients, etc.

### Recipe Parsing and Conversion
- [ ] <code>[50%]</code> Automatic conversion of recipes to Behavior Trees (BTs)
  - Using CURD (Carnegie Mellon University Recipe Database)
  - Open-SESAME parser
- Parser for converting natural language recipes into planning problems

## 7. Inventory Management

### Pantry Tracking
- ✅ Manual inventory input
- ✅ Barcode scanning for quick item addition
- 🚧 Automatic inventory deduction based on meal plan usage

### Expiration Management
- [ ] <code>[10%]</code> Tracking of product expiration dates
- [ ] <code>[10%]</code> Smart notifications for items nearing expiration
- Planning tool to avoid food spoilage and expiration in various storage conditions

### Fridge/Freezer Monitoring
- ✅ Temperature and door sensors for fridges and freezers
- ✅ Tracking pantry inventory changes
- ✅ Ensuring food safety
- [ ] <code>[20%]</code> Follow-up dialog regarding intent when fridge and freezer accessed

### Shopping List Generation
- ✅ Manual addition and removal of items
- 🚧 Automatic list creation based on meal plans and inventory

### Receipt Tracking
- [ ] <code>[50%]</code> Receipt tracker
- [ ] <code>[25%]</code> Bill splitter for shared groceries

## 8. Nutrition Analysis

### Nutritional Calculations
- ✅ Calculation of macronutrients (protein, carbs, fats) and calories
- [ ] <code>[20%]</code> Logging and planning of macros
- 🚧 Tracking of essential vitamins and minerals
- 🚧 Consideration of bioavailability and nutrient interactions

### Reporting and Visualization
- ✅ Basic nutritional overview of meal plans
- [ ] <code>[0%]</code] Detailed nutritional reports and trend analysis
- 🚧 Visual representations of nutritional balance

### User Modeling and Health Tracking
- [ ] <code>[40%]</code> Self-discipline coach for hitting macros and understanding food psychology
- Checking for common symptoms known to affect the user (e.g., GERD, lactose intolerance)
- Inference of food sensitivities
- Nutritional temporal records with privacy preservation
- Integration with health temporal records for empirical analysis
- Detection and allowance for genetic factors affecting diet and health

## 9. Shopping and Ordering

### Grocery Store Integration
- [ ] <code>[10%]</code> Integration with major online grocery retailers
- 🚧 Price comparison across multiple stores
- 🚧 Support for local and specialty stores

### Order Optimization
- 🚧 Basic order consolidation to minimize delivery fees
- 🚧 Advanced order splitting for cost optimization across stores

### Delivery Tracking
- ✅ Basic order status tracking
- 🚧 Integration with delivery services for real-time updates

## 10. Special Diets and Restrictions

### Food Ontology
- [ ] <code>[33%]</code> Comprehensive food ontology development
  - Food properties encoded into Prolog factbase
  - Medical properties such as allergies
  - Food storage duration knowledge
  - Food similarity using word embeddings
  - Food substitutions (changing, adding, or canceling)
  - Normalization / mapping NL descriptions to entities in a KB

### Supported Diets
- 🚧 Vegetarian and vegan
- 🚧 Gluten-free
- 🚧 Ketogenic
- 🚧 Paleo
- 🚧 Low-FODMAP
- Support for ethical diets (e.g., vegan, pescatarian)
- Support for medical diets (e.g., diabetic, gall bladder issues)

### Allergy Management
- 🚧 Common allergen avoidance (e.g., nuts, dairy, shellfish)
- 🚧 Customizable allergen profiles
- 🚧 Cross-contamination risk assessment

### Medical Diet Support
- [ ] <code>[10%]</code> Diabetic-friendly meal planning
- [ ] <code>[10%]</code> Low-sodium diet planning
- 🚧 Renal diet support

## 11. AI and Machine Learning

### Personalization
- 🚧 Basic preference learning from user interactions
- 🚧 Advanced taste profile modeling
- 🚧 Predictive modeling of user satisfaction

### Natural Language Processing
- [ ] <code>[50%]</code> Recipe parsing and normalization
- [ ] <code>[30%]</code> Ingredient entity recognition and linking

### Computer Vision
- ✅ Barcode recognition for product identification
- 🚧 Image-based food recognition and logging

## 12. Data Sources and Integration

### Food Databases
- ✅ USDA Food Data Central
- ✅ Open Food Facts
- ✅ Nutritionix
- 🚧 Specialized databases for international cuisines

### Recipe Sources
- ✅ SOAR Recipe Archive (150,000 recipes)
- 🚧 Integration with popular recipe websites
- 🚧 User-generated recipe repository

### External Integrations
- [ ] <code>[0%]</code] Fitness tracker data for personalized energy requirements
- [ ] <code>[0%]</code] Weather data for seasonal recipe suggestions
- Integration with Hetionet for empirical analysis of nutritional factors associated with medical conditions

## 13. Privacy and Security

### Data Protection
- 🚧 Encryption of user data at rest and in transit
- Privacy-preserving nutritional temporal records

### User Controls
- 🚧 Granular privacy settings for data sharing
- 🚧 Data export and deletion capabilities

### Compliance
- 🚧 GDPR compliance for EU users
- 🚧 CCPA compliance for California residents

## 14. Customization and Extensibility

### API Access
- 🚧 RESTful API for third-party integrations
- 🚧 WebHooks for real-time data updates

### Plugin System
- 🚧 Framework for community-developed plugins

## 15. Troubleshooting

### Common Issues
- Barcode scanning failures
- Recipe import errors
- Synchronization issues with external services

### Logging and Diagnostics
- ✅ Detailed application logs
- 🚧 User-accessible diagnostic tools

### Support Channels
- ✅ Community forums for peer support

## 16. Future Work

- Advanced nutritional modeling for long-term health outcome prediction
- Expansion of the food ontology to cover global cuisines and ingredients
- Development of a companion mobile app for real-time meal tracking and adjustments
- Implementation of a gamification system to encourage healthy eating habits
- Semi-automatic Rapid Knowledge Formation (RKF) of textual knowledge bases regarding food safety
- Integration with transportation and building hours APIs for complex food provision scenarios (e.g., homelessness, lack of transportation)
- Automatic detection of inventory items which have been recalled or linked to disease outbreaks
- Proper handling of food items lacking barcodes
- Emergency food and water provision management
  - Stocking enough provisions to survive n-months
  - Rotating emergency food and water provisions
- Food pantry patronage support

## 17. Contributing

Gourmet is an open-source project and welcomes contributions from the community. Ways to contribute include:

- Code contributions (see CONTRIBUTING.md for guidelines)
- Recipe submissions and curation
- Translation and localization efforts
- Documentation improvements
- Bug reports and feature suggestions

## 18. License

Gourmet is released under the GNU General Public License v3.0. See the LICENSE file for full details.

---

This reference manual provides a comprehensive overview of the Gourmet system, its features, and ongoing development efforts. As the project evolves, this manual will be updated to reflect new capabilities and improvements.
