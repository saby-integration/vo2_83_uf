&НаКлиенте
Перем Кэш;
#Область include_local_ПолучитьМодульОбъекта
#КонецОбласти

//функция обновляет контент для подразделов раздела Справочники	
&НаКлиенте
Функция ОбновитьКонтент(ЛокальныйКэш) Экспорт
	//СтруктураДляОбновленияФормы = Кэш.ОбщиеФункции.сбисОбновитьРеестрДокументов1С(Ини, Кэш);
	Кэш = ЛокальныйКэш;
	ГлавноеОкно = Кэш.ГлавноеОкно;
	ИмяРеестра = "";
	ИмяРаздела = "Справочники";
	Ини = "";
	Если Не Кэш.Разделы[ИмяРаздела].Свойство(Кэш.Текущий.Имя, ИмяРеестра) Тогда
		Возврат Ложь;
	КонецЕсли;
		
	//Снимем видимость у панелей, не принадлежащих текущему разделу
	СтраницыПанели = Кэш.ОбщиеФункции.СбисПолучитьЭлементФормы(Кэш,, ИмяРаздела + "_Подразделы");
	СтраницыПанели.ТекущаяСтраница = Кэш.ОбщиеФункции.СбисПолучитьЭлементФормы(Кэш, СтраницыПанели, "Неопределено");
	
	РеестрСправочниковСтраницы = Кэш.ОбщиеФункции.СбисПолучитьЭлементФормы(Кэш,, "РеестрСправочниковСтраницы");
	СтраницаПрайсЛист = ГлавноеОкно.сбисПолучитьСтраницу(РеестрСправочниковСтраницы, "СтраницаПрайсЛист");
	Если Не РеестрСправочниковСтраницы.ТекущаяСтраница = СтраницаПрайсЛист Тогда
		РеестрСправочниковСтраницы.ТекущаяСтраница = СтраницаПрайсЛист;	
	КонецЕсли;      
	
	//+++ 1187075631 TODO После завершения проекта по сопоставлению номенклатуры сделать видимым для способов "на онлайне" и "ДБФ" 
	Если МодульОбъектаКлиент().ПолучитьЗначениеФичи(Новый Структура("НазваниеФичи", "РасширенныйФункционалСопоставленияНоменклатуры")) Тогда
	//Если Кэш.ФормаРаботыСНоменклатурой = "СопоставлениеНоменклатуры_ДБФ" Тогда
		УстановитьОтображениеСтраниц(РеестрСправочниковСтраницы, ИмяРеестра = "Номенклатура");
	Иначе
		УстановитьОтображениеСтраниц(РеестрСправочниковСтраницы, Ложь);
	КонецЕсли;
	
	фрм = ГлавноеОкно.сбисНайтиФормуФункции("ОбновитьКонтент","Раздел_" + ИмяРаздела + "_" + ИмяРеестра,, Кэш);
	Если Не фрм = Ложь Тогда
		Возврат фрм.ОбновитьКонтент(ЛокальныйКэш);
	КонецЕсли;

	Если Не Кэш.Ини.Свойство(ИмяРеестра,Ини) Тогда
		Возврат Ложь;
	ИначеЕсли Ини = Неопределено Тогда
		Ини = Кэш.ФормаНастроек.Ини(Кэш, ИмяРеестра);
	КонецЕсли;
	Кэш.Текущий.ТипДок = ИмяРеестра;
	
	Контент					= ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "Контент");
	ПанельМассовыхОпераций	= ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "ПанельМассовыхОпераций");
	Кэш.ТаблДок				= ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "Таблица_РеестрСправочников");
	Контент.ТекущаяСтраница	= ГлавноеОкно.сбисПолучитьСтраницу(Контент, "РеестрСправочников");	
	
	НаСменуРаздела(Кэш);//Вызываем руками, чтобы изменилась панель операций.

	ГлавноеОкно.сбисЗаполнитьСписокСправочника(Кэш.ФормаНастроек.Ини(Кэш, ИмяРеестра));
КонецФункции

&НаКлиенте
Функция ОбновитьКонтентПодговитьРаздел(ПараметрыОбновления, ДопПараметры) Экспорт
	
	Кэш = ДопПараметры.Кэш;  
	ИмяРеестра = "";
	ИмяРаздела = "Справочники";
	Если Кэш.Разделы[ИмяРаздела].Свойство(Кэш.Текущий.Имя, ИмяРеестра) Тогда
		фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("ОбновитьКонтент","Раздел_" + ИмяРаздела + "_" + ИмяРеестра,, Кэш);
		Если Не фрм = Ложь Тогда
			Возврат фрм.ОбновитьКонтентПодговитьРаздел(ПараметрыОбновления, ДопПараметры);
		КонецЕсли;
	КонецЕсли;

	НаСменуРаздела(Кэш);
	НастроитьКолонки(Кэш);
	НавигацияУстановитьПанель(Кэш);	
	Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ПанельФильтра").Видимость = Ложь;
	Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ПоказатьПанельФильтра").Видимость = Ложь;

КонецФункции

&НаКлиенте
Процедура НастроитьКолонки(Кэш) Экспорт  
	
	МассивРеквизитов = Новый Массив;
	МассивРеквизитов.Добавить("ЕдиницаИзмерения");
	МассивРеквизитов.Добавить("Характеристика");

	Кэш.ГлавноеОкно.НастроитьКолонкиФормы(Новый Структура("ИмяТаблицы, СтруктураПолей", "Таблица_РеестрСправочников", Новый Структура("КолонкиУдалить", МассивРеквизитов)));

КонецПроцедуры

//Процедура устанавливает панель навигации на 1ую страницу и скрывает панель	
&НаКлиенте
Процедура НавигацияУстановитьПанель(ЛокальныйКэш=Неопределено) Экспорт
	ГлавноеОкно = ЛокальныйКэш.ГлавноеОкно;
	ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "ПанельНавигации").Видимость		= Ложь;
	ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "ЗаписейНаСтранице1С").Видимость	= Ложь;
	ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно, "ЗаписейНаСтранице").Видимость	= Ложь;
КонецПроцедуры

&НаКлиенте
Процедура НаСменуРаздела(ЛокальныйКэш) Экспорт
	Кэш = ЛокальныйКэш;
	ГлавноеОкно = Кэш.ГлавноеОкно;
	ПанельМассовыхОпераций = Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно, "ПанельМассовыхОпераций");
	Попытка
		ПанельМассовыхОпераций.ТекущаяСтраница = Кэш.ГлавноеОкно.сбисПолучитьСтраницу(ПанельМассовыхОпераций,"Справочники" + Кэш.Текущий.ТипДок);
		Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ПанельТулбар").Видимость = Истина;
	Исключение
		ПанельМассовыхОпераций.ТекущаяСтраница = Кэш.ГлавноеОкно.сбисПолучитьСтраницу(ПанельМассовыхОпераций,"Справочники");
		Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ПанельТулбар").Видимость = Истина;
	КонецПопытки;
	
	Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ОтметитьВсе7").Видимость 	= Истина; 
	Кэш.ГлавноеОкно.сбисЭлементФормы(Кэш.ГлавноеОкно,"ОтметитьВсе13").Видимость = Ложь; 	
	
	ТекущийИмя	= Кэш.Текущий.Имя;
	РодительИмя	= "Справочники";
	КнопкаИмя = "СправочникиОтправить";
	Кэш.ГлавноеОкно.сбисОчиститьПанельКнопок(Новый Структура("Имя, УправляемоеПриложение", КнопкаИмя, Кэш.ПараметрыСистемы.Клиент.УправляемоеПриложение), Ложь);
	
	сбисРазделМеню = Кэш.МенюРазделов;
	//Заполним команды из инишек и стандартные
	Если	сбисРазделМеню.Свойство(РодительИмя,	сбисРазделМеню)
		И	сбисРазделМеню.Свойство(ТекущийИмя,		сбисРазделМеню) Тогда
		ДобавитьКнопки = Новый Массив;
		//Проверим, не переназначены ли стандартные команды через ини
		Для Каждого Пункт Из сбисРазделМеню Цикл
			Для сч = 0 По ДобавитьКнопки.Количество()-1 Цикл
				Если ДобавитьКнопки[сч]["ИмяКнопки"] = Пункт["ИмяКнопки"] Тогда
					ДобавитьКнопки.Удалить(сч);
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
		Для Каждого КнопкаДобавить Из ДобавитьКнопки Цикл
			сбисРазделМеню.Добавить(КнопкаДобавить);
		КонецЦикла;
	Иначе
		Возврат;
	КонецЕсли;
	//Добавим кнопки в Отправить
	Для Каждого Пункт Из сбисРазделМеню Цикл
		Если Не ЗначениеЗаполнено(Пункт.МетодАктивации) Тогда
			Продолжить;
		КонецЕсли;
		Отказ			= Ложь;
		ПараметрыКнопки = Новый Структура(
			"Имя,				Заголовок,																		Панель,					УправляемоеПриложение", 
			Пункт.ИмяКнопки,	?(Пункт.Свойство("ЗаголовокКнопки"), Пункт.ЗаголовокКнопки, Пункт.ИмяКнопки),	КнопкаИмя,	Кэш.ПараметрыСистемы.Клиент.УправляемоеПриложение);
		РезультатФормированияКнопки = Кэш.ГлавноеОкно.сбисДобавитьКнопку(ПараметрыКнопки, Отказ);
		Если Отказ Тогда
			Кэш.ГлавноеОкно.сбисСообщитьОбОшибке(Кэш, РезультатФормированияКнопки);
		КонецЕсли;
	КонецЦикла;		
	
	
	ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно,"ПанельФильтра").Видимость = Ложь;
	ГлавноеОкно.сбисЭлементФормы(ГлавноеОкно,"ПоказатьПанельФильтра").Видимость = Ложь;
КонецПроцедуры  

&НаКлиенте
Процедура УстановитьОтображениеСтраниц(Страницы, ОтображатьСтраницы) Экспорт   
	#Если Не ТолстыйКлиентОбычноеПриложение Тогда
		Если ОтображатьСтраницы Тогда   
			Страницы.ОтображениеСтраниц 	= ОтображениеСтраницФормы.ЗакладкиСверху; 
		Иначе
			Страницы.ОтображениеСтраниц 	= ОтображениеСтраницФормы.Нет; 
		КонецЕсли;  
	#Иначе  
		Если ОтображатьСтраницы Тогда   
			Страницы.ОтображениеЗакладок 	= ОтображениеЗакладок.Сверху;
		Иначе      
			Страницы.ОтображениеЗакладок 	= ОтображениеЗакладок.НеИспользовать;
		КонецЕсли;
	#КонецЕсли
КонецПроцедуры