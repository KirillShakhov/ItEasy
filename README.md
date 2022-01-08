# ItEasy
Swift Application
Проект по предмету Low-level programming/Programming languages

Ссылка на видео: [YouTube](https://youtu.be/yc_Dshega1c)
Более качественный ролик будет немного позже

## Идея
У приложения сложилась хорошая идея, простого приложения с рецептами. Во первых это приложения с рецептиками,
которые можно легко и просто посмотреть. А во вторых, приложение позволяет выбирать меню на неделю, где на каждый день будет несколько рецептов. 
Оно позволяет смотреть рецепты на текущий день недели и подготавливает список необходимых ингридиентов на день. 
Что позволяет просто зайти по дороге в магазин и купить не достающие продукты.

## Реализация
* Приложение разработанно на языке Swift
* Серверная часть написана на Spring
Ссылка на BackEnd: [ItEasy.BackEnd](https://github.com/KirillShakhov/ItEasy.BackEnd)

## Архитектура
MVP во всех смыслах.

Во первых это Minimum Viable Product - продукт, обладающий минимальными, но достаточными для удовлетворения первых потребителей функциями.

А также стандартные инструменты Apple нацелены на архитекруту MVC в итоге приводят нас к MVP.

В MVP view это просто шаблок, а всей его работой отвечает Presenter. Например за отображение и хранения данных в таблицах.

## Выводы
Во время выполнения проекта я изучил пользностью новый и неизвестный мне до этого язык программирования Swift, 
который как оказалось имеет много общего с Object-C и есть что-то от Clojure.
Также познакомился с шаблонами проектирования MV(X): MVC, MVP, MVVM. После долгих тестов, был выбран самый подходящий MVP шаблон. 
Бэкенд был написан очень быстро, там не было ничего сложного и, с большим опытом, его удалось закончить за пару дней.
У этого проекта будет будущее, мне он очень понравился, я буду и дальше его развивать.
