# E-Commerce Inventory API

This is a Ruby on Rails-based API for managing product inventories in an e-commerce system. It supports product, category, stock tracking, and promotion/discount features.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Create User Manually](#create-user-manually)

---

## Requirements

- **Ruby**: 3.4.2
- **Rails**: 7.x or 8.x
- **PostgreSQL**: Recommended for database

---

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/singgiaditya/ecommerce-inventory-api.git
   cd ecommerce-inventory-api
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Set up the database**

   - Copy the example database config and update it with your credentials:

     ```bash
     cp config/database.yml.example config/database.yml
     ```

   - Create and migrate the database:

     ```bash
     rails db:create
     rails db:migrate
     ```

---

## Usage

To start the development server:

```bash
rails server
```

Visit `http://localhost:3000` to access your API locally.

---

## API Documentation

Full API documentation is available in the Postman public workspace below:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://www.postman.com/quirkly/ecommerce-inventory-api)


---

## Create User Manually

Since there's no public registration endpoint, you need to create users manually via Rails console:

1. Open the Rails console:

   ```bash
   rails console
   ```

2. Create a new user:

   ```ruby
   User.create!(
     email: 'user@example.com',
     password: 'password123',
     name: 'user'
   )
   ```

Replace the email, name and password as needed.

---