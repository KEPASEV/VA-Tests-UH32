﻿#language: ru
@tree

@UH32_Purchases

Функционал: 01. Под профилем "Администратор". Настройки (Сквозное планирование потребности = Нет)

	Как бизнес-аналитик я хочу
	проверить создание документов подситемы и закрытие регистров
	чтобы исключить ошибки

Контекст:

	И я подключаю TestClient "УХ - Закупки1" логин "Администратор" пароль ""
	И я закрыл все окна клиентского приложения

Сценарий: 01.00. Полные права: инициализация

	И я закрываю TestClient "УХ - НСИ"
	И я закрываю TestClient "УХ - Бюджетирование"
	И я закрываю TestClient "УХ - Закупки1"
	И я закрываю TestClient "УХ - Закупки2"
	И я закрываю TestClient "УХ - Дымовые"	

	И Я запоминаю значение выражения 'ИдентификацияПродуктаУХКлиентСервер.ЭтоУправлениеХолдингом() И НЕ ИдентификацияПродуктаУХКлиентСервер.ЭтоЕХ()' в переменную "$$ЭтоУХ$$"
	И Я запоминаю значение выражения 'ИдентификацияПродуктаУХКлиентСервер.ЭтоУправлениеХолдингом() И ИдентификацияПродуктаУХКлиентСервер.ЭтоЕХ()' в переменную "$$ЭтоЕРПУХ$$"
	И Я запоминаю значение выражения 'ИдентификацияПродуктаУХКлиентСервер.ВерсияУправлениеХолдингом()' в переменную "$$ВерсияУХ$$"
	И Я запоминаю значение выражения 'СокрЛП(ТекущаяДата())' в переменную "$$ТекущаяДата$$"	
	И я устанавливаю в константу "ИспользоватьВыплатыСамозанятым" значение "Ложь"
	
Сценарий: 01.01. Корпоративные закупки (настройки)

	* Открываем настройки
	
		И В командном интерфейсе я выбираю 'Общие справочники и настройки' 'Корпоративные закупки'
		Тогда открылось окно 'Корпоративные закупки'

	* Не требовать регистрации участников открытых закупок	
	
		И я устанавливаю флаг с именем 'НеТребоватьРегистрацииУчастниковДляОткрытыхСпособовЗакупок'
		
	* Типы цен номенклатуры
	
		Если не существует элемент справочника "ТипыЦенНоменклатуры" с "Наименование" равным "Плановые цены" Тогда
			
			И Я открываю основную форму справочника "ТипыЦенНоменклатуры"
			И в поле с именем 'Наименование' я ввожу текст 'Плановые цены'
			И я перехожу к следующему реквизиту
			И из выпадающего списка с именем "ВалютаЦены" я выбираю точное значение 'RUB'
			И я изменяю флаг с именем 'ЦенаВключаетНДС'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Плановые цены (Тип цены номенклатуры)' в течение 20 секунд
		
	* Тип цен для расценки потребности
	
		И я нажимаю кнопку выбора у поля с именем "ТипЦенДляРасценкиЗаявокНаПотребность"
		Тогда открылось окно 'Типы цен номенклатуры'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'  | 'Валюта' |
			| 'Плановые цены' | 'RUB'    |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Корпоративные закупки'

	* Правило заполнения статьи бюджета - по ТК
	
		И из выпадающего списка с именем "ПравилоЗаполненияСтатьиБюджета" я выбираю точное значение 'По товарной категории'
		И я нажимаю на кнопку с именем 'ФормаНастроитьСтатьи'
		Тогда открылось окно 'Настройки статей'
		
		* ТК Товары
		
			И в таблице "СтатьиТК" я перехожу к строке:
				| 'Товарная категория' |
				| 'ТК Товары'          |
			
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаУсловиеОплаты"
			И в таблице "СтатьиТК" я выбираю текущую строку
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаУсловиеОплаты"
			Тогда открылось окно 'Условия оплаты'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'                                       |
				| 'Аванс 50% за 30 к.д., Постоплата 50% через 30 к.д.' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
				
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаСтатьяБюджета"
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаСтатьяБюджета"
			Тогда открылось окно 'Статьи движения денежных средств'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'  					 |
				| 'Оплата поставщикам (подрядчикам)' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
			И в таблице "СтатьиТК" я завершаю редактирование строки

		* ТК Работы

			И в таблице "СтатьиТК" я перехожу к строке:
				| 'Товарная категория' |
				| 'ТК Работы'          |
			
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаУсловиеОплаты"
			И в таблице "СтатьиТК" я выбираю текущую строку
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаУсловиеОплаты"
			Тогда открылось окно 'Условия оплаты'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'          |
				| 'Аванс 100% за 10 к.д.' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
				
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаСтатьяБюджета"
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаСтатьяБюджета"
			Тогда открылось окно 'Статьи движения денежных средств'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'   |
				| 'Прочие расходы' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
			И в таблице "СтатьиТК" я завершаю редактирование строки
		
		* ТК Услуги
		
			И в таблице "СтатьиТК" я перехожу к строке:
				| 'Товарная категория' |
				| 'ТК Услуги'          |
			
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаУсловиеОплаты"
			И в таблице "СтатьиТК" я выбираю текущую строку
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаУсловиеОплаты"
			Тогда открылось окно 'Условия оплаты'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'         		  |
				| 'Постоплата 100% через 10 к.д.' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
				
			И в таблице "СтатьиТК" я активизирую поле с именем "ПланыДокументаСтатьяБюджета"
			И в таблице "СтатьиТК" я нажимаю кнопку выбора у реквизита с именем "ПланыДокументаСтатьяБюджета"
			Тогда открылось окно 'Статьи движения денежных средств'
			И в таблице "Список" я перехожу к строке:
				| 'Наименование'   |
				| 'Прочие расходы' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Настройки статей'
			И в таблице "СтатьиТК" я завершаю редактирование строки
	
		И я нажимаю на кнопку с именем 'ФормаЗакрыть'
	
	* Способ расчета даты поставки - конец периода
	
		И из выпадающего списка с именем "СпособРасчетаДатыОперацииПериода" я выбираю точное значение 'Конец периода'
	
	* Виды операций поступления по видам номенклатуры - заполняем
	
		И я нажимаю на кнопку с именем 'НастроитьВидыОперацийПоступленияПоВидамНоменклатуры'
		Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
	
		* Малоценное оборудование и запасы
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'                 |
				| 'Малоценное оборудование и запасы' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Оборудование'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'

		* Спецодежда
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Спецодежда'       |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Спецоснастка

			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Спецоснастка'     |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Оборудование'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Инвентарь и хозяйственные принадлежности
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'                         |
				| 'Инвентарь и хозяйственные принадлежности' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'		
		
		* Возвратная тара
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'|
				| 'Возвратная тара' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Топливо
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'|
				| 'Топливо'         |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Топливо'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Услуги
			
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'|
				| 'Услуги'          |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Услуги'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Товары на комиссии
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'   |
				| 'Товары на комиссии' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Товары на ответственном хранении
	
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'                 |
				| 'Товары на ответственном хранении' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	

		* Полуфабрикаты
	
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Полуфабрикаты'    |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Материалы в переработку'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	
		
		* Продукция

			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Продукция'        |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Товары'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	
		
		* Продукция из материалов заказчика
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Продукция из материалов заказчика'    |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Материалы в переработку'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	

		* Материалы
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Материалы'    |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Материалы в переработку'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	
		
		* Оборудование (объекты основных средств)
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'                        |
				| 'Оборудование (объекты основных средств)' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Основные средства'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
		
		* Оборудование к установке
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры'         |
				| 'Оборудование к установке' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Оборудование'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'
	
		* Работы
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Работы' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Услуги'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'

		* Услуги
		
			И в таблице "Список" я активизирую поле с именем "ВидОперацииПоступления"
			И в таблице "Список" я перехожу к строке:
				| 'Вид номенклатуры' |
				| 'Услуги' |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Вид операций поступления по виду номенклатуры'
			И из выпадающего списка с именем "ВидОперацииПоступления" я выбираю точное значение 'Услуги'
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна 'Вид операций поступления по виду номенклатуры *' в течение 20 секунд
			Тогда открылось окно 'Виды операций поступления по видам номенклатуры'	
	
		И Я закрываю окно 'Виды операций поступления по видам номенклатуры'
		Тогда открылось окно 'Корпоративные закупки'
			
	* Сквозное планирование потребности - выключено
	
		И я снимаю флаг с именем 'СквозноеПланированиеПотребности'
	
	* Проводить экпертизу - в тесте экспертизу не используем
	
		И я меняю значение переключателя с именем 'ВариантЭкспертизы' на 'Не проводить'
		
	* Закрываем настройки
	
		И Я закрываю окно 'Корпоративные закупки'

Сценарий: 01.02. Приказ о назначении закупочной комиссии

		И В командном интерфейсе я выбираю 'Корпоративные закупки' 'Приказы закупочной комиссии'
		Тогда открылось окно 'Приказы закупочной комиссии'
		
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Приказы закупочной комиссии (создание)'
		
		И в таблице "ЗакупочнаяКомиссия" я нажимаю на кнопку с именем 'ЗакупочнаяКомиссияДобавить'
		
		И в таблице "ЗакупочнаяКомиссия" я нажимаю кнопку выбора у реквизита с именем "ЗакупочнаяКомиссияОрганизация"
		Тогда открылось окно 'Организационные единицы'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование в программе' |
			| 'Королевство Севера [223]' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Приказы закупочной комиссии (создание) *'
		
		И в таблице "ЗакупочнаяКомиссия" я активизирую поле с именем "ЗакупочнаяКомиссияДолжность"
		И в таблице "ЗакупочнаяКомиссия" я нажимаю кнопку выбора у реквизита с именем "ЗакупочнаяКомиссияДолжность"
		Тогда открылось окно 'Должности'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование' |
			| 'Инженер'      |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Приказы закупочной комиссии (создание) *'
		
		И я перехожу к следующему реквизиту
		И в таблице "ЗакупочнаяКомиссия" я нажимаю кнопку выбора у реквизита с именем "ЗакупочнаяКомиссияРоль"
		И в таблице "ЗакупочнаяКомиссия" из выпадающего списка с именем "ЗакупочнаяКомиссияРоль" я выбираю точное значение 'Председатель комиссии'

		И я перехожу к следующему реквизиту
		И в таблице "ЗакупочнаяКомиссия" я нажимаю кнопку выбора у реквизита с именем "ЗакупочнаяКомиссияСотрудник"
		Тогда открылось окно 'Физические лица'
		И в таблице "Список" я перехожу к строке:
			| 'ФИО'            |
			| 'Мормонт Джорах' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Приказы закупочной комиссии (создание) *'
		
		И в таблице "ЗакупочнаяКомиссия" я завершаю редактирование строки

		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Приказы закупочной комиссии (создание) *' в течение 20 секунд
		Тогда открылось окно 'Приказы закупочной комиссии'
		И Я закрываю окно 'Приказы закупочной комиссии'

Сценарий: 01.03. Установка цен номенклатуры

	* Открываем список документов установки цен

		И В командном интерфейсе я выбираю 'Склад' 'Установка цен номенклатуры'
		Тогда открылось окно 'Установка цен номенклатуры'
		
	* Регистрируем новый документ

		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Установка цен номенклатуры (создание)'
	
	* Дата документа
	
		И в поле с именем 'Дата' я ввожу текст '01.01.2022  0:00:00'
	
	* Тип цен = Закупочные цены
	
		И я нажимаю кнопку выбора у поля с именем "ТипЦен"
		Тогда открылось окно 'Типы цен номенклатуры'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'  | 'Валюта' |
			| 'Плановые цены' | 'RUB'    |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Установка цен номенклатуры (создание) *'

	* Заполняем табличную часть

		И я заполняю таблицу "Товары" данными
			| 'Номенклатура'  | 'Цена'         |
			| 'Материал1'     | '1 000,00'     |
			| 'Материал2'     | '1 300,00'     |
			| 'Материал3'     | '1 500,00'     |
			| 'ОС1'           | '2 500 300,00' |
			| 'Товар1'        | '10 000,00'    |
			| 'Товар2'        | '8 500,00'     |
			| 'Товар3'        | '5 333,00'     |				
			| 'Товар4'        | '15 254,00'    |
			| 'Товар5'        | '25 000,00'    |
			| 'Товар6'        | '101 980,00'   |
			| 'Работа1'       | '8 500 000,00' |
			| 'Работа2'       | '426 800,00'   |
			| 'Работа3'       | '18 000,00'    |
			| 'Услуга1'       | '300 000,00'   |
			| 'Услуга2'       | '24 000,00'    |
			| 'Услуга3'       | '46 000,00'    |
			| 'Спецодежда1'   | '6 250,00'     |
			| 'Топливо1'      | '54,00'        |
			| 'Спецоснастка1' | '45 000,00'    |			

//		И я устанавливаю УстановкаЦенНоменклатуры "Материал1", цена = "1 000,00"	
//		И я устанавливаю УстановкаЦенНоменклатуры "Материал2", цена = "1 300,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Материал3", цена = "1 500,00"	
//		И я устанавливаю УстановкаЦенНоменклатуры "ОС1", цена = "2 500 300,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар1", цена = "10 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар2", цена = "8 500,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар3", цена = "5 333,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар4", цена = "15 254,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар5", цена = "25 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Товар6", цена = "101 980,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Работа1", цена = "8 500 000,00"	
//		И я устанавливаю УстановкаЦенНоменклатуры "Работа2", цена = "426 800,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Работа3", цена = "18 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Услуга1", цена = "300 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Услуга2", цена = "24 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Услуга3", цена = "46 000,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Спецодежда1", цена = "6 250,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Топливо1", цена = "54,00"
//		И я устанавливаю УстановкаЦенНоменклатуры "Спецоснастка1", цена = "45 000,00"
	
	* Записываем и закрываем документ
	
		Когда открылось окно 'Установка цен номенклатуры (создание) *'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Установка цен номенклатуры (создание) *' в течение 20 секунд
		Тогда открылось окно 'Установка цен номенклатуры'
		И Я закрываю окно 'Установка цен номенклатуры'
		
Сценарий: 01.04. Расширяем профиль группы доступа для МенеджерПоЗакупкам1

	* Открываем настройки пользователей и прав
	
		И В панели разделов я выбираю 'Общие справочники и настройки'
		И В командном интерфейсе я выбираю 'Администрирование' 'Настройки пользователей и прав'
		Тогда открылось окно 'Настройки пользователей и прав'
		
	* Открываем группы доступа
	
		И я нажимаю на кнопку с именем 'ОткрытьГруппыДоступа'
		Тогда открылось окно 'Группы доступа'
		
	* Создаем группу доступа "Оценка предложений поставщиков"	
	
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Группа доступа (создание)'
		И в поле с именем 'Наименование' я ввожу текст 'Оценка предложений поставщиков'
		И я перехожу к следующему реквизиту
		И я нажимаю кнопку выбора у поля с именем "Профиль"
		Тогда открылось окно 'Выбор профиля групп доступа'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'               |
			| 'Оценка и выбор альтернатив' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Группа доступа (создание) *'
		И в таблице "Пользователи" я нажимаю на кнопку с именем 'ПользователиПодобрать'
		Тогда открылось окно 'Подбор участников группы доступа'
		И в таблице "ПользователиСписок" я перехожу к строке:
			| 'Полное имя'          |
			| 'МенеджерПоЗакупкам1' |
		И в таблице "ПользователиСписок" я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ЗавершитьИЗакрытьВыбор'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Группа доступа (создание) *' в течение 20 секунд
		
	* Создаем группу доступа "Бюджетирование и казначейство"
	
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Группа доступа (создание)'
		И в поле с именем 'Наименование' я ввожу текст 'Бюджетирование и казначейство'
		И я перехожу к следующему реквизиту
		И я нажимаю кнопку выбора у поля с именем "Профиль"
		Тогда открылось окно 'Выбор профиля групп доступа'
		И в таблице "Список" я перехожу к строке:
			| 'Наименование'                  |
			| 'Бюджетирование и казначейство' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Группа доступа (создание) *'
		И в таблице "Пользователи" я нажимаю на кнопку с именем 'ПользователиПодобрать'
		Тогда открылось окно 'Подбор участников группы доступа'
		И в таблице "ПользователиСписок" я перехожу к строке:
			| 'Полное имя'          |
			| 'МенеджерПоЗакупкам1' |
		И в таблице "ПользователиСписок" я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ЗавершитьИЗакрытьВыбор'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Группа доступа (создание) *' в течение 20 секунд
		И я закрываю все окна клиентского приложения

