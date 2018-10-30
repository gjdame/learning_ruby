class Quotes
	def initialize
		@quotes_list = [
		"My greatest pain in life is that I will never be able to see myself perform live.",
		"Sometimes people write novels and they just be so wordy and so self-absorbed. I am not a fan of books. I would never want a book's autograph. I am a proud non-reader of books",
		"I hate when I'm on a flight and I wake up with a water bottle next to me like oh great now I gotta be responsible for this water bottle",
		"I don't even listen to rap. My apartment is too nice to listen to rap in.",
		"I feel like I'm too busy writing history to read it",
		"I believe that bad taste is vulgar. It's like cursing. I think the world can be saved through design, because what is the most distasteful thing someone can do? Kill someone. So, good taste is the opposite of that.",
		"Just imagine if I woke up one day and I was whack. What would I do then?"
		]
	end

	def generate
		@quotes_list.sample
	end
end

