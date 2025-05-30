# [Diploma Work – Educational Platform](https://diploma-work.org/)

This project was created as part of my Bachelor's degree thesis:  
🔗 [https://diploma-work.org/](https://diploma-work.org/)

> ⚠️ **Note:** This project was built in a rush specifically for my bachelor’s defense. Please don’t judge my technical skills solely based on this code 🙂

## Description

The platform is designed to support the educational process in schools and universities. It provides basic functionality for:
- course management;
- uploading and reviewing educational materials;
- grading system;
- basic plagiarism detection.

## Tech Stack

- **Ruby on Rails**: 7.2  
- **Ruby**: 3.2.2  
- **Deployment**: via [Kamal](https://kamal-deploy.org/) to a DigitalOcean Droplet

## Getting Started

### Prerequisites

- Ruby 3.2.2
- PostgreSQL
- Redis
- Node.js & Yarn
- ImageMagick (for ActiveStorage variants)
- Docker (optional for deployment)

### Setup

```bash
# Clone the repository
git clone https://github.com/Tarasukk/Diploma.git
cd diploma

# Install dependencies
bundle install
yarn install

# Set up the database
rails db:setup

# Start the server
bin/dev
