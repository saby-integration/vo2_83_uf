
&НаКлиенте
Процедура НастроитьКолонки(Кэш) Экспорт
	Кэш.ОбщиеФункции.НастроитьКолонки(Неопределено, Кэш); // alo СтатусГос
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовСклад.Заголовок = "Подразделение";
КонецПроцедуры
&НаКлиенте
Процедура ФильтрУстановитьВидимость(ФормаФильтра) Экспорт
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентПодключен");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентСФилиалами");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрОтветственный");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрТипыДокументов");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрМаска");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
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
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовЛицо2.Видимость = Ложь;
	Кэш.ОбщиеФункции.НастроитьКолонки(Неопределено, Кэш);
КонецПроцедуры

