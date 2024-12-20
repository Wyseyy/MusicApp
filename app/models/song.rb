class Song < ApplicationRecord
    def mark_as_favorite
        self.update(favorite: true)
      end
end
