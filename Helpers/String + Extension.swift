extension String {
    func shortName() -> String {
        if self == "Понедельник" {
            return "Пн"
        } else if self == "Вторник" {
            return "Вт"
        } else if self == "Среда" {
            return "Ср"
        } else if self == "Четверг" {
            return "Чт"
        } else if self == "Пятница" {
            return "Пт"
        } else if self == "Суббота" {
            return "Сб"
        } else if self == "Воскресенье" {
            return "Вс"
        }
        return String(self.prefix(2))
    }
}
