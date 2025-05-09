# HotelApp
HotelApp – iOS-приложение для управления небольшой гостиницей, разработанное на SwiftUI с использованием Supabase как backend-платформы. Функционал с возможностью бронирования, просмотра меню кухни и туристических маршрутов, пуш-уведомлений. Приложение полностью клиентское и может быть адаптировано под любую гостиницу.

💡 Ключевые возможности:

🛏 Список свободных номеров
	•	Загрузка данных из Supabase (PostgreSQL)
	•	Фильтрация по доступности (is_available)
	•	Отображение названия, описания, цены и изображения номера

📅 Бронирование номеров
	•	Выбор даты заселения/выселения
	•	Проверка доступности
	•	Запись данных о бронировании в базу

📸 Фото номеров
	•	Загрузка изображений в Supabase Storage
	•	Подгрузка и кеширование в приложении через AsyncImage

🍳 Меню кухни
	•	Поддержка категорий: завтрак, обед, ужин
	•	Вывод описания блюд, состава и стоимости
	•	Возможность отметить интересующее питание при бронировании

🗺 Туристические маршруты
	•	Вывод интерактивных карточек достопримечательностей
	•	Ссылки на карты и гайды по городу

👤 Авторизация пользователей
	•	Email + пароль через Supabase Auth
	•	Хранение бронирований пользователя
	•	Magic link (опционально)

📦 Работа с базой данных Supabase (PostgreSQL)
	•	insert, select, filter, update — всё через SDK
	•	Реализована безопасная RLS-политика

⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻

🛠 Используемые технологии
	•	SwiftUI – для построения современного, декларативного пользовательского интерфейса
	•	Supabase – как backend-платформа: база данных PostgreSQL, API, аутентификация и хранилище файлов
	•	PostgreSQL – реляционная база данных, используемая внутри Supabase
	•	Supabase Storage – для загрузки и хранения изображений номеров
	•	Supabase Auth – регистрация и вход пользователей (email, пароль)
	•	MVVM (Model-View-ViewModel) – архитектурный паттерн для разделения UI и бизнес-логики
	•	Swift Concurrency (async/await) – для асинхронной работы с API
	•	Swift Package Manager (SPM) – управление внешними зависимостями
	•	Xcode 15+ – среда разработки

⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻

💼 Навыки, которые демонстрирует проект

✅ Архитектура приложения (MVVM)
✅ Интеграция с облачной базой данных
✅ Работа с авторизацией и безопасностью
✅ Работа с асинхронными потоками
✅ Создание полностью нативного клиентского UI
✅ Подключение и настройка внешнего SDK (Supabase)

⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻

🔜 Планируемые улучшения
	•	Push-уведомления для подтверждения брони
	•	Интеграция с картами для построения маршрутов
	•	Админ-панель для управления номерами
	•	Офлайн-режим (кеширование)
	•	Поддержка нескольких языков (RU / EN)

⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻

📱 Скриншоты

(добавлю позже)

⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻

👤 Автор проекта

Александр Шульга
iOS Developer
Связаться: 
mail: sasha_shulga0507@mail.ru
telegram: @bubble_fuq
whatsapp: +7 917 173 21 30

