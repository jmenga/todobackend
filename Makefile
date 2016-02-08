.PHONY: test build release clean  

test:
	docker-compose -f docker/dev/docker-compose.yml build
	docker-compose -f docker/dev/docker-compose.yml up agent
	docker-compose -f docker/dev/docker-compose.yml up test

build:
	docker-compose -f docker/dev/docker-compose.yml up builder

release:
	docker-compose -f docker/release/docker-compose.yml build
	docker-compose -f docker/release/docker-compose.yml up agent
	docker-compose -f docker/release/docker-compose.yml run --rm app manage.py collectstatic --noinput
	docker-compose -f docker/release/docker-compose.yml run --rm app manage.py migrate --noinput
	docker-compose -f docker/release/docker-compose.yml up test

clean:
	docker-compose -f docker/dev/docker-compose.yml kill
	docker-compose -f docker/dev/docker-compose.yml rm -f
	docker-compose -f docker/release/docker-compose.yml kill
	docker-compose -f docker/release/docker-compose.yml rm -f