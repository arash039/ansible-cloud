setup:
	if [ ! -d .venv ]; then python3 -m venv .venv; fi
	. .venv/bin/activate && pip install -r requirements.txt

encrypt:
	. .venv/bin/activate && ansible-vault encrypt vault.yml

decrypt:
	. .venv/bin/activate && ansible-vault decrypt vault.yml

playbook:
	. .venv/bin/activate && ansible-playbook -c paramiko -i inventory.ini playbook.yml --ask-vault-pass

teardown:
	. .venv/bin/activate && ansible-playbook -c paramiko -i inventory.ini tear_down_playbook.yml

.PHONY: setup encrypt view-vault ping inventory playbook teardown
