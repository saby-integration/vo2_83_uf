	Если Лев(СбисИмяРаздела, 8) = "Blockly_" Тогда
		ТекущийРаздел.Вставить("Идентификатор", СбисИмяРаздела);
		ПоказатьШаблон();
		Возврат Истина;
	Иначе
		ЭлемФормы = ПолучитьЭлементыФормы();
		ПанельКонтент = ЭлемФормы.ПанельКонтент;
		ПанельКонтент.ТекущаяСтраница = ПолучитьСтраницуНаКлиенте(ПанельКонтент, "СтраницаВО2");
		Возврат ПерейтиВРазделВО2(СбисИмяРаздела, ДопПараметры);
	КонецЕсли;
