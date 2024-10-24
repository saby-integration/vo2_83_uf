
// функция обновляет контент для подразделов раздела Продажа	
//
// Параметры:
//  Кэш	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
&НаКлиенте
Функция ОбновитьКонтент(Кэш) Экспорт
	
	МестныйКэш	= Кэш;
	ИмяРеестра	= "";
	Ини			= "";
	Если Кэш.Разделы.Продажа.Свойство(Кэш.Текущий.Имя,ИмяРеестра)=Ложь Тогда
		Сообщить("Отсутствует настройка для перехода в раздел. Доступные настройки можно подключить на вкладке ""Настройки/Файлы настроек""");
		Возврат Ложь;
	КонецЕсли;
	Если Кэш.ини.Свойство(ИмяРеестра,Ини)=Ложь Тогда
		Возврат Ложь;
	ИначеЕсли Ини = Неопределено Тогда
		Ини = Кэш.ФормаНастроек.Ини(Кэш, ИмяРеестра);
	КонецЕсли;
	Кэш.Текущий.ТипДок = ИмяРеестра;
	СтруктураДляОбновленияФормы = Кэш.ОбщиеФункции.сбисОбновитьРеестрДокументов1С(Ини, Кэш);
	
	Кэш.ОбщиеФункции.ОбновитьПанельНавигации(Кэш);
	ГлавноеОкно = Кэш.ГлавноеОкно;
	
	Контент					= МодульОбъектаКлиент().ПолучитьЭлементФормыОбработки(ГлавноеОкно,	"Контент");
	Контент.ТекущаяСтраница	= МодульОбъектаКлиент().ПолучитьЭлементФормыОбработки(Контент,		"РеестрДокументов");
	
	Кэш.ТаблДок = МодульОбъектаКлиент().ПолучитьЭлементФормыОбработки(ГлавноеОкно, "Таблица_РеестрДокументов");
	
	ГлавноеОкно.СписокДопОперацийРеестра.Очистить();
	
	МодульОбъектаКлиент().ПолучитьЭлементФормыОбработки(ГлавноеОкно, "ДопОперации2").Видимость = Ложь;
	Если Ини.Свойство("ДопОперацияРеестра")  Тогда
		Для Каждого ДопОперация Из Ини.ДопОперацияРеестра Цикл
			Кэш.ГлавноеОкно.СписокДопОперацийРеестра.Добавить(ДопОперация.Значение.Операция.Функция1С, Кэш.ОбщиеФункции.РассчитатьЗначение("Операция", ДопОперация.Значение, Кэш));
			сбисЭлементФормы(Кэш.ГлавноеОкно,"ДопОперации2").Видимость = Истина;
		КонецЦикла;
	КонецЕсли;
	
	Возврат СтруктураДляОбновленияФормы;
	
КонецФункции

&НаКлиенте
Процедура НавигацияУстановитьПанель(Кэш) Экспорт
// Процедура устанавливает панель навигации на 1ую страницу и скрывает панель	
	ГлавноеОкно = Кэш.ГлавноеОкно;
	сбисЭлементФормы(ГлавноеОкно,"ПанельНавигации").Видимость=Истина;
	сбисЭлементФормы(ГлавноеОкно,"ЗаписейНаСтранице1С").Видимость=Истина;
	сбисЭлементФормы(ГлавноеОкно,"ЗаписейНаСтранице").Видимость=Ложь;
КонецПроцедуры
&НаКлиенте
Процедура ФильтрУстановитьВидимость(ФормаФильтра) Экспорт
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентПодключен");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентСФилиалами");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрОтветственный");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрТипыДокументов");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрМаска");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
		// << alo СтатусГос 
		ИмяРеестра="";
		Если МестныйКэш.Разделы.Продажа.Свойство(МестныйКэш.Текущий.Имя,ИмяРеестра) Тогда
			Ини="";
			Если МестныйКэш.ини.Свойство(ИмяРеестра,Ини) Тогда
				Ини = МестныйКэш.ФормаНастроек.Ини(МестныйКэш, ИмяРеестра);
				ЗапросСпискаДокументов="";
				Если ини.Свойство("ЗапросСпискаДокументов",ЗапросСпискаДокументов) Тогда
					ВыбранныйЭлемент.Видимость =? (Найти(ЗапросСпискаДокументов.Значение,"&Маска") >0, Истина,Ложь);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;	// alo СтатусГос >>
	КонецЕсли; 
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"НадписьНоменклатураКонтрагента");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;    
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"НадписьНоменклатура1С");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;   
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"НадписьКодКонтрагента");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;  
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"НадписьGTIN");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли; 
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрНоменклатура1С");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;   
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКодКонтрагента");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;  
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрGTIN");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура сбисОформлениеДопПолейРеестра(Кэш) Экспорт
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовСрок.Видимость = Ложь;
	////сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовЛицо2.Видимость = Ложь;
КонецПроцедуры

