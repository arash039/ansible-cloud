## Overview
This project automates the deployment of a WordPress application using Ansible. It includes roles for setting up:
- A Caddy web server
- A Docker environment
- A MariaDB database
- A WordPress application

## Prerequisites
Before using this repository, ensure you have the following installed:

- Ansible (version specified in `requirements.txt`)
- Docker and Docker Compose
- Python 3.x
- SSH access to the target servers

## Folder Structure
```
cl/
├── ansible.cfg                # Configuration file for Ansible
├── inventory.ini              # Inventory file for defining target hosts
├── Makefile                   # Makefile for common tasks
├── playbook.yml               # Main Ansible playbook
├── requirements.txt           # Python dependencies for Ansible
├── tear_down_playbook.yml     # Playbook for tearing down the setup
├── vault.yml                  # Encrypted variables file
└── roles/                     # Ansible roles directory
    ├── caddy/                 # Role for setting up Caddy web server
    │   ├── files/             # Static files for Caddy
    │   │   ├── Dockerfile     # Dockerfile for Caddy
    │   │   └── conf/          # Configuration files for Caddy
    │   │       └── Caddyfile  # Caddy server configuration
    │   └── tasks/             # Tasks for setting up Caddy
    │       └── main.yml       # Main tasks file for Caddy
    ├── docker/                # Role for setting up Docker
    │   ├── files/             # Static files for Docker
    │   │   └── docker-compose.yml # Docker Compose configuration
    │   ├── tasks/             # Tasks for setting up Docker
    │   │   └── main.yml       # Main tasks file for Docker
    │   └── templates/         # Jinja2 templates for Docker
    │       └── .env.j2        # Environment variables template
    ├── mariadb/               # Role for setting up MariaDB
    │   ├── files/             # Static files for MariaDB
    │   │   ├── Dockerfile     # Dockerfile for MariaDB
    │   │   └── conf/          # Configuration files for MariaDB
    │   │       ├── init_sql.sh # Initialization script for MariaDB
    │   │       └── mariadb-server.cnf # MariaDB server configuration
    │   └── tasks/             # Tasks for setting up MariaDB
    │       └── main.yml       # Main tasks file for MariaDB
    └── wordpress/             # Role for setting up WordPress
        ├── files/             # Static files for WordPress
        │   ├── Dockerfile     # Dockerfile for WordPress
        │   ├── conf/          # Configuration files for WordPress
        │   │   ├── memory.ini # PHP memory configuration
        │   │   └── www.conf   # PHP-FPM configuration
        │   └── tools/         # Tools for WordPress setup
        │       └── entrypoint.sh # Entrypoint script for WordPress
        └── tasks/             # Tasks for setting up WordPress
            └── main.yml       # Main tasks file for WordPress
```

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd cl
   ```

2. Install the required Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Update the `inventory.ini` file with the details of your target servers.

4. If using sensitive data, update the `vault.yml` file and encrypt it using Ansible Vault:
   ```bash
   ansible-vault encrypt vault.yml
   ```

5. Run the main playbook to deploy the infrastructure:
   ```bash
   ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
   ```

## Usage
- To deploy the infrastructure, run the main playbook as described in the setup instructions.
- To customize configurations, modify the files in the `roles` directory as needed.

## Roles

### Caddy
This role sets up the Caddy web server using Docker. It includes:
- A `Dockerfile` for building the Caddy image
- A `Caddyfile` for server configuration
- Tasks for deploying and configuring Caddy

### Docker
This role sets up Docker and Docker Compose on the target servers. It includes:
- A `docker-compose.yml` file for managing containers
- A `.env.j2` template for environment variables
- Tasks for installing and configuring Docker

### MariaDB
This role sets up a MariaDB database using Docker. It includes:
- A `Dockerfile` for building the MariaDB image
- Initialization and configuration scripts
- Tasks for deploying and configuring MariaDB

### WordPress
This role sets up a WordPress application using Docker. It includes:
- A `Dockerfile` for building the WordPress image
- PHP configuration files
- An entrypoint script for WordPress setup
- Tasks for deploying and configuring WordPress

## Tear Down
To remove the deployed infrastructure, run the tear-down playbook:
```bash
ansible-playbook -i inventory.ini tear_down_playbook.yml --ask-vault-pass
```

