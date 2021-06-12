# frozen_string_literal: true

# This is for views only really...
module Flashy
  extend ActiveSupport::Concern

  included do
    def add_flash_error(flash_hash, message)
      add_flash(flash_hash, message, :error)
    end

    def add_flash_success(flash_hash, message)
      add_flash(flash_hash, message, :success)
    end

    def add_flash_info(flash_hash, message)
      add_flash(flash_hash, message, :info)
    end

    def add_flash(flash_hash, message, type)
      flash_hash_copy = flash_hash.deep_dup

      flash_hash_copy[:g] = {} if flash_hash_copy[:g].blank?
      flash_hash_copy[:g][type] = [] if flash_hash_copy[:g][type].blank?

      flash_hash_copy[:g][type].push(message)
      flash_hash_copy
    end
  end
end
