# Description

Create three services, integrated through simplest possible `REST` API, each in different programming language. Technologically each service is independent, but obviously on business level one of them will require both to be available in order to proceed.

So first two services will have `REST` API for managing entities: User and Room. Each service is independent, each has different storage. Integration is possible only via `REST` API. Failure each of them does not break anything else.

Main service which will manage Booking, requires all two services to be available. If any of them is not available, no mutable operation on booking cannot performed. Only listing the basic information about bookings (without details about room and user) and deleting bookings should be possible under such conditions.

Storage for each service should be independent, but it does not mean that it has to be different. It only means that we prohibit integration through database.

Try to create each one with proper tests (ideally - with `TDD`).
