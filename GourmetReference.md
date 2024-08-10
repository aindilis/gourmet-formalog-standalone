# Gourmet Reference Manual

## This Document is Under Construction

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
- [ ] <code>[0%]</code> Recipe recommendation system
- [ ] <code>[30%]</code> Interactive cooking assistant for guided recipe preparation
- [ ] <code>[30%]</code> Inventory management with product expiration tracking
- [ ] <code>[15%]</code> Integration with major online grocery retailers for easy ordering

### In Progress Features
- [ ] <code>[5%]</code> Advanced dietary preference and restriction handling
- [ ] <code>[0%]</code> AI-powered recipe creation and modification
- [ ] <code>[10%]</code> Comprehensive food ontology for ingredient relationships and substitutions
- [ ] <code>[30%]</code> Natural language processing for recipe import and normalization

### Planned Features
- [ ] Meal plan optimization for long-term health outcomes
- [ ] Collaborative meal planning for households and groups
- [ ] Integration with personal health data for tailored nutrition advice
- [ ] Seasonal and local food prioritization

## 3. System Architecture

Gourmet is built on a modular architecture that allows for easy expansion and integration with other systems. Key components include:

- Core Planning Engine: Prolog-based PDDL planner for meal plan generation
- Data Layer: Manages interactions with various food and recipe databases
- User Interface: Web-based frontend for user interactions
- AI Module: Handles machine learning tasks for personalization and recipe analysis
- Integration Layer: Manages connections with external services (e.g., grocery stores, FLP modules)

## 4. User Interface

### Web Interface
- Responsive design for desktop and mobile use
- Dashboard with meal plan overview, shopping lists, and quick actions
- Recipe browser with filtering and search capabilities
- Inventory management interface
- Settings and preference configuration

### Mobile App
- [ ] <code>[20%]</code> Native mobile app for iOS and Android (in development)
- Barcode scanning functionality
- Quick meal logging and inventory updates
- Shopping list management

### Voice Assistant Integration
- ✅ Basic Alexa skill for querying meal plans and adding items to shopping list
- [ ] <code>[40%]</code> Enhanced voice interactions for hands-free cooking assistance

## 5. Meal Planning

### Plan Generation
- ✅ Constraint-based planning using nutritional requirements, preferences, and inventory
- ✅ Support for different plan durations (daily, weekly, monthly)
- [ ] <code>[70%]</code> Consideration of leftover ingredients and batch cooking opportunities

### Customization
- ✅ Ability to swap out suggested meals
- ✅ Manual addition of custom meals to the plan
- [ ] <code>[50%]</code> Fine-tuning of nutritional targets and preferences

### Optimization
- ✅ Basic cost optimization
- [ ] <code>[60%]</code> Advanced multi-objective optimization (nutrition, cost, preparation time, variety)

## 6. Recipe Management

### Recipe Database
- ✅ Integration of 300,000+ recipes from SOAR Recipe Archive
- ✅ User ability to add custom recipes
- [ ] <code>[40%]</code> Automatic nutritional analysis of custom recipes

### Recipe Recommendations
- ✅ Basic collaborative filtering for personalized suggestions
- [ ] <code>[70%]</code> Advanced ML-based recommendation system considering nutritional needs, preferences, and past behavior

### Recipe Scaling and Adjustment
- ✅ Automatic scaling of recipes based on serving size
- [ ] <code>[30%]</code> Intelligent ingredient substitution suggestions

## 7. Inventory Management

### Pantry Tracking
- ✅ Manual inventory input
- ✅ Barcode scanning for quick item addition
- [ ] <code>[80%]</code> Automatic inventory deduction based on meal plan usage

### Expiration Management
- ✅ Tracking of product expiration dates
- [ ] <code>[60%]</code> Smart notifications for items nearing expiration
- [ ] <code>[40%]</code> Suggestion of recipes to use soon-to-expire items

### Shopping List Generation
- ✅ Automatic list creation based on meal plans and inventory
- ✅ Manual addition and removal of items
- [ ] <code>[50%]</code> Integration with store layouts for optimized shopping routes

## 8. Nutrition Analysis

### Nutritional Calculations
- ✅ Calculation of macronutrients (protein, carbs, fats) and calories
- ✅ Tracking of essential vitamins and minerals
- [ ] <code>[70%]</code> Consideration of bioavailability and nutrient interactions

### Reporting and Visualization
- ✅ Basic nutritional overview of meal plans
- [ ] <code>[40%]</code> Detailed nutritional reports and trend analysis
- [ ] <code>[20%]</code> Visual representations of nutritional balance

### Goal Setting and Tracking
- ✅ Basic goal setting for macronutrients
- [ ] <code>[50%]</code> Advanced health goal tracking and recommendations

## 9. Shopping and Ordering

### Grocery Store Integration
- ✅ Integration with major online grocery retailers
- [ ] <code>[30%]</code> Price comparison across multiple stores
- [ ] <code>[20%]</code> Support for local and specialty stores

### Order Optimization
- ✅ Basic order consolidation to minimize delivery fees
- [ ] <code>[40%]</code> Advanced order splitting for cost optimization across stores

### Delivery Tracking
- ✅ Basic order status tracking
- [ ] <code>[30%]</code> Integration with delivery services for real-time updates

## 10. Special Diets and Restrictions

### Supported Diets
- [ ] <code>[0%]</code> Vegetarian and vegan
- [ ] <code>[0%]</code> Gluten-free
- [ ] <code>[0%]</code> Ketogenic
- [ ] <code>[0%]</code> Paleo
- [ ] <code>[0%]</code> Low-FODMAP

### Allergy Management
- ✅ Common allergen avoidance (e.g., nuts, dairy, shellfish)
- [ ] <code>[0%]</code> Customizable allergen profiles
- [ ] <code>[0%]</code> Cross-contamination risk assessment

### Medical Diet Support
- [ ] <code>[10%]</code> Diabetic-friendly meal planning
- [ ] <code>[10%]</code> Low-sodium diet planning
- [ ] <code>[0%]</code> Renal diet support

## 11. AI and Machine Learning

### Personalization
- [ ] <code>[0%]</code> Basic preference learning from user interactions
- [ ] <code>[0%]</code> Advanced taste profile modeling
- [ ] <code>[0%]</code> Predictive modeling of user satisfaction

### Natural Language Processing
- [ ] <code>[50%]</code> Recipe parsing and normalization
- [ ] <code>[30%]</code> Ingredient entity recognition and linking

### Computer Vision
- ✅ Barcode recognition for product identification
- [ ] <code>[0%]</code> Image-based food recognition and logging

## 12. Data Sources and Integration

### Food Databases
- ✅ USDA Food Data Central
- ✅ Open Food Facts
- [ ] <code>[0%]</code> Specialized databases for international cuisines

### Recipe Sources
- ✅ SOAR Recipe Archive
- [ ] <code>[0%]</code> Integration with popular recipe websites
- [ ] <code>[0%]</code> User-generated recipe repository

### External Integrations
- [ ] <code>[0%]</code> Fitness tracker data for personalized energy requirements
- [ ] <code>[0%]</code> Weather data for seasonal recipe suggestions

## 13. Privacy and Security

### Data Protection
- [ ] <code>[0%]</code> Encryption of user data at rest and in transit

### User Controls
- [ ] <code>[0%]</code> Granular privacy settings for data sharing
- [ ] <code>[0%]</code> Data export and deletion capabilities

### Compliance
- [ ] <code>[0%]</code> GDPR compliance for EU users
- [ ] <code>[0%]</code> CCPA compliance for California residents

## 14. Customization and Extensibility

### API Access
- [ ] <code>[0%]</code> RESTful API for third-party integrations
- [ ] <code>[0%]</code> WebHooks for real-time data updates

### Plugin System
- [ ] <code>[0%]</code> Framework for community-developed plugins

## 15. Troubleshooting

### Common Issues
- Barcode scanning failures
- Recipe import errors
- Synchronization issues with external services

### Logging and Diagnostics
- ✅ Detailed application logs
- [ ] <code>[0%]</code> User-accessible diagnostic tools

### Support Channels
- ✅ Community forums for peer support

## 16. Future Work

- Advanced nutritional modeling for long-term health outcome prediction
- Expansion of the food ontology to cover global cuisines and ingredients
- Development of a companion mobile app for real-time meal tracking and adjustments
- Implementation of a gamification system to encourage healthy eating habits

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
