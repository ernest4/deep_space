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

    def flashes
      flash.to_h.with_indifferent_access[:g]&.except("form").presence || {}
    end

    def add_flash_form_error(form_name, flash_hash, error)
      flash_hash_copy = flash_hash.deep_dup

      flash_hash_copy[:g] = {} if flash_hash_copy[:g].blank?
      flash_hash_copy[:g][:form] = {} if flash_hash_copy[:g][:form].blank?
      flash_hash_copy[:g][:form][form_name] = {} if flash_hash_copy[:g][:form][form_name].blank?

      flash_hash_copy[:g][:form][form_name][error.attribute] = error.detail
      flash_hash_copy
    end

    def flash_form_error(form_name, attribute)
      flash.to_h.with_indifferent_access.dig(:g, :form, form_name, attribute)
    end
  end
end
