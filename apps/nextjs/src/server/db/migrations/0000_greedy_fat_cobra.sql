CREATE TYPE "public"."enum__locales" AS ENUM('lt', 'en');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cta_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cwm_buttons_link_type" AS ENUM('External', 'Internal');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cwm_header_section_header_level" AS ENUM('h2', 'h3', 'h4', 'h5', 'h6');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cwm_image_image_position" AS ENUM('backgroundTop', 'backgroundBottom', 'backgroundCenter', 'backgroundLeft', 'backgroundRight');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cwm_image_orientation" AS ENUM('landscape', 'square');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_cwm_text_position" AS ENUM('Left', 'Right', 'Foreground');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_features_columns" AS ENUM('2', '3', '4');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_final_cta_variant" AS ENUM('card', 'full');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_image_alignment" AS ENUM('left', 'center', 'right', 'full');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_stats_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_blocks_text_alignment" AS ENUM('left', 'center', 'right');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_published_locale" AS ENUM('lt', 'en');--> statement-breakpoint
CREATE TYPE "public"."enum__pages_v_version_status" AS ENUM('draft', 'published');--> statement-breakpoint
CREATE TYPE "public"."enum__posts_v_published_locale" AS ENUM('lt', 'en');--> statement-breakpoint
CREATE TYPE "public"."enum__posts_v_version_content_image_image_position" AS ENUM('backgroundTop', 'backgroundBottom', 'backgroundCenter', 'backgroundLeft', 'backgroundRight');--> statement-breakpoint
CREATE TYPE "public"."enum__posts_v_version_content_media_video_host" AS ENUM('youtube', 'vimeo');--> statement-breakpoint
CREATE TYPE "public"."enum__posts_v_version_status" AS ENUM('draft', 'published');--> statement-breakpoint
CREATE TYPE "public"."enum_global_settings_social_links_platform" AS ENUM('facebook', 'twitter', 'instagram', 'linkedin', 'youtube', 'github', 'tiktok');--> statement-breakpoint
CREATE TYPE "public"."enum_media_credit_creator_type" AS ENUM('Person', 'Organization');--> statement-breakpoint
CREATE TYPE "public"."enum_oauth_application_type" AS ENUM('web', 'mobile', 'public');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cta_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cwm_buttons_link_type" AS ENUM('External', 'Internal');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cwm_header_section_header_level" AS ENUM('h2', 'h3', 'h4', 'h5', 'h6');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cwm_image_image_position" AS ENUM('backgroundTop', 'backgroundBottom', 'backgroundCenter', 'backgroundLeft', 'backgroundRight');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cwm_image_orientation" AS ENUM('landscape', 'square');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_cwm_text_position" AS ENUM('Left', 'Right', 'Foreground');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_features_columns" AS ENUM('2', '3', '4');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_image_alignment" AS ENUM('left', 'center', 'right', 'full');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_stats_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum_page_templates_blocks_text_alignment" AS ENUM('left', 'center', 'right');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cta_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cwm_buttons_link_type" AS ENUM('External', 'Internal');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cwm_header_section_header_level" AS ENUM('h2', 'h3', 'h4', 'h5', 'h6');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cwm_image_image_position" AS ENUM('backgroundTop', 'backgroundBottom', 'backgroundCenter', 'backgroundLeft', 'backgroundRight');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cwm_image_orientation" AS ENUM('landscape', 'square');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_cwm_text_position" AS ENUM('Left', 'Right', 'Foreground');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_features_columns" AS ENUM('2', '3', '4');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_final_cta_variant" AS ENUM('card', 'full');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_image_alignment" AS ENUM('left', 'center', 'right', 'full');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_stats_background_color" AS ENUM('default', 'primary', 'secondary');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_blocks_text_alignment" AS ENUM('left', 'center', 'right');--> statement-breakpoint
CREATE TYPE "public"."enum_pages_status" AS ENUM('draft', 'published');--> statement-breakpoint
CREATE TYPE "public"."enum_posts_content_image_image_position" AS ENUM('backgroundTop', 'backgroundBottom', 'backgroundCenter', 'backgroundLeft', 'backgroundRight');--> statement-breakpoint
CREATE TYPE "public"."enum_posts_content_media_video_host" AS ENUM('youtube', 'vimeo');--> statement-breakpoint
CREATE TYPE "public"."enum_posts_status" AS ENUM('draft', 'published');--> statement-breakpoint
CREATE TYPE "public"."enum_user_subscriptions_currency" AS ENUM('usd', 'eur');--> statement-breakpoint
CREATE TYPE "public"."enum_user_subscriptions_recurring_interval" AS ENUM('month', 'year');--> statement-breakpoint
CREATE TYPE "public"."enum_user_subscriptions_status" AS ENUM('active', 'canceled', 'past_due', 'unpaid', 'trialing', 'incomplete', 'incomplete_expired');--> statement-breakpoint
CREATE TYPE "public"."enum_users_role" AS ENUM('user', 'admin');--> statement-breakpoint
CREATE TABLE "copilotkit_runs" (
	"run_id" text PRIMARY KEY NOT NULL,
	"thread_id" uuid NOT NULL,
	"parent_run_id" text,
	"events" jsonb NOT NULL,
	"created_at" bigint NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"parent_id" uuid,
	"version_slug" varchar,
	"version_status" "enum__pages_v_version_status" DEFAULT 'published',
	"version_page_template_id" uuid,
	"version_meta_canonical" varchar,
	"version_meta_site_name" varchar DEFAULT 'Human Maps',
	"version_updated_at" timestamp(3) with time zone,
	"version_created_at" timestamp(3) with time zone,
	"version__status" "enum__pages_v_version_status" DEFAULT 'draft',
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"snapshot" boolean,
	"published_locale" "enum__pages_v_published_locale",
	"latest" boolean,
	"autosave" boolean
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_10" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_10_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_2" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_2_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_3" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_3_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_4" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_4_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_5" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 5,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_5_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_6" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 6,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_6_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_7" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_7_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_8" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"max_posts" numeric DEFAULT 4,
	"view_all_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_8_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_index" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"posts_per_page" numeric DEFAULT 9,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_index_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_section" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"posts_limit" numeric DEFAULT 3,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_blog_section_locales" (
	"title" varchar,
	"subtitle" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_cta" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"button_link" varchar,
	"secondary_button_link" varchar,
	"background_color" "enum__pages_v_blocks_cta_background_color" DEFAULT 'default',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_cta_locales" (
	"title" varchar,
	"description" varchar,
	"button_text" varchar,
	"secondary_button_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_cwm" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"active" boolean DEFAULT true,
	"header_section_header_text" varchar,
	"header_section_header_level" "enum__pages_v_blocks_cwm_header_section_header_level" DEFAULT 'h2',
	"header_section_anchor" varchar,
	"image_image_id" uuid,
	"image_image_position" "enum__pages_v_blocks_cwm_image_image_position" DEFAULT 'backgroundCenter',
	"image_orientation" "enum__pages_v_blocks_cwm_image_orientation",
	"content" jsonb,
	"text_position" "enum__pages_v_blocks_cwm_text_position",
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_cwm_buttons" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar,
	"link_type" "enum__pages_v_blocks_cwm_buttons_link_type" DEFAULT 'External',
	"link" varchar,
	"open_in_new_tab" boolean DEFAULT false,
	"is_primary" boolean,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_faq" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_faq_items" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_faq_items_locales" (
	"question" varchar,
	"answer" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_faq_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_features" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"columns" "enum__pages_v_blocks_features_columns" DEFAULT '3',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_features_features" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"icon_id" uuid,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_features_features_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_features_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_final_cta" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"button_link" varchar,
	"variant" "enum__pages_v_blocks_final_cta_variant" DEFAULT 'card',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_final_cta_locales" (
	"title" varchar,
	"description" varchar,
	"button_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_framework" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_framework_dimensions" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_framework_dimensions_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_framework_locales" (
	"badge" varchar,
	"title" varchar,
	"title_line2" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_hero" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"background_image_id" uuid,
	"cta_link" varchar,
	"secondary_cta_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_hero_locales" (
	"title" varchar,
	"subtitle" varchar,
	"description" jsonb,
	"cta_text" varchar,
	"secondary_cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_image" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"image_id" uuid,
	"alignment" "enum__pages_v_blocks_image_alignment" DEFAULT 'center',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_image_locales" (
	"caption" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_landing_hero" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"cta_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_landing_hero_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_mechanism" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"cta_link" varchar,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_mechanism_locales" (
	"title" varchar,
	"description" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_mechanism_steps" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_mechanism_steps_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_pricing" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_pricing_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_stats" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"background_color" "enum__pages_v_blocks_stats_background_color" DEFAULT 'default',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_stats_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_stats_stats" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"value" varchar,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_stats_stats_locales" (
	"label" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_testimonials_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_testimonials_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"author_name" varchar,
	"author_image_id" uuid,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_testimonials_testimonials_locales" (
	"quote" varchar,
	"author_title" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_text" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"content_html" varchar,
	"alignment" "enum__pages_v_blocks_text_alignment" DEFAULT 'left',
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_text_locales" (
	"content" jsonb,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is_cards" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is_cards_benefits" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"_uuid" varchar
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is_cards_benefits_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is_cards_locales" (
	"badge" varchar,
	"title" varchar,
	"title_highlight" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_blocks_what_is_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_locales" (
	"version_title" varchar,
	"version_meta_title" varchar,
	"version_meta_description" varchar,
	"version_meta_image_id" uuid,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_pages_v_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"posts_id" uuid
);
--> statement-breakpoint
CREATE TABLE "_posts_v" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"parent_id" uuid,
	"version_status" "enum__posts_v_version_status" DEFAULT 'published',
	"version_featured" boolean DEFAULT false,
	"version_date" timestamp(3) with time zone,
	"version_link" varchar,
	"version_content_media_include_audio" boolean DEFAULT false,
	"version_content_media_include_video" boolean DEFAULT false,
	"version_content_media_audio" varchar,
	"version_content_media_video_host" "enum__posts_v_version_content_media_video_host" DEFAULT 'youtube',
	"version_content_media_youtube" varchar,
	"version_content_media_vimeo" varchar,
	"version_content_image_image_id" uuid,
	"version_content_image_image_position" "enum__posts_v_version_content_image_image_position" DEFAULT 'backgroundCenter',
	"version_content_richtext_html" varchar,
	"version_meta_canonical" varchar,
	"version_meta_site_name" varchar DEFAULT 'Human Maps',
	"version_updated_at" timestamp(3) with time zone,
	"version_created_at" timestamp(3) with time zone,
	"version__status" "enum__posts_v_version_status" DEFAULT 'draft',
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"snapshot" boolean,
	"published_locale" "enum__posts_v_published_locale",
	"latest" boolean,
	"autosave" boolean
);
--> statement-breakpoint
CREATE TABLE "_posts_v_locales" (
	"version_title" varchar,
	"version_slug" varchar,
	"version_content_description" varchar,
	"version_content_summary" varchar,
	"version_content_rich_text" jsonb,
	"version_meta_title" varchar,
	"version_meta_description" varchar,
	"version_meta_image_id" uuid,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "_posts_v_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"users_id" uuid,
	"categories_id" uuid
);
--> statement-breakpoint
CREATE TABLE "categories" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"slug" varchar,
	"meta_canonical" varchar,
	"meta_site_name" varchar DEFAULT 'Human Maps',
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "categories_locales" (
	"title" varchar NOT NULL,
	"content_description" jsonb,
	"meta_title" varchar,
	"meta_description" varchar,
	"meta_image_id" uuid,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "global_settings" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"business_name" varchar,
	"domain" varchar,
	"google_tag_manager_code" varchar,
	"contact_info_email" varchar,
	"contact_info_phone" varchar,
	"logo_light_id" uuid,
	"logo_dark_id" uuid,
	"logo_alt" varchar,
	"updated_at" timestamp(3) with time zone,
	"created_at" timestamp(3) with time zone
);
--> statement-breakpoint
CREATE TABLE "global_settings_locales" (
	"contact_info_address" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "global_settings_social_links" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"platform" "enum_global_settings_social_links_platform" NOT NULL,
	"url" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "jwks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"public_key" varchar NOT NULL,
	"private_key" varchar NOT NULL,
	"expires_at" timestamp(3) with time zone,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "media" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar,
	"alt_description" varchar,
	"credit_creator" varchar,
	"credit_creator_type" "enum_media_credit_creator_type",
	"credit_creator_link" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"url" varchar,
	"thumbnail_u_r_l" varchar,
	"filename" varchar,
	"mime_type" varchar,
	"filesize" numeric,
	"width" numeric,
	"height" numeric,
	"focal_x" numeric,
	"focal_y" numeric
);
--> statement-breakpoint
CREATE TABLE "oauth_access_token" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"access_token" varchar NOT NULL,
	"refresh_token" varchar,
	"access_token_expires_at" timestamp(3) with time zone NOT NULL,
	"refresh_token_expires_at" timestamp(3) with time zone,
	"client_id_id" uuid NOT NULL,
	"user_id_id" uuid NOT NULL,
	"scopes" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "oauth_application" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"client_id" varchar NOT NULL,
	"client_secret" varchar,
	"name" varchar NOT NULL,
	"redirect_u_r_ls" varchar,
	"metadata" varchar,
	"type" "enum_oauth_application_type" DEFAULT 'web' NOT NULL,
	"disabled" boolean DEFAULT false,
	"user_id_id" uuid,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "oauth_consent" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id_id" uuid NOT NULL,
	"client_id_id" uuid NOT NULL,
	"scopes" varchar,
	"consent_given" boolean DEFAULT true NOT NULL,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar NOT NULL,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_10" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_10_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_2" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_2_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_3" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_3_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_4" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_4_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_5" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 5,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_5_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_6" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 6,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_6_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_7" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_7_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_8" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 4,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_blog_8_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_cta" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"button_link" varchar NOT NULL,
	"secondary_button_link" varchar,
	"background_color" "enum_page_templates_blocks_cta_background_color" DEFAULT 'default',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_cta_locales" (
	"title" varchar NOT NULL,
	"description" varchar,
	"button_text" varchar NOT NULL,
	"secondary_button_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_cwm" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"active" boolean DEFAULT true,
	"header_section_header_text" varchar,
	"header_section_header_level" "enum_page_templates_blocks_cwm_header_section_header_level" DEFAULT 'h2',
	"header_section_anchor" varchar,
	"image_image_id" uuid,
	"image_image_position" "enum_page_templates_blocks_cwm_image_image_position" DEFAULT 'backgroundCenter',
	"image_orientation" "enum_page_templates_blocks_cwm_image_orientation",
	"content" jsonb,
	"text_position" "enum_page_templates_blocks_cwm_text_position",
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_cwm_buttons" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"title" varchar,
	"link_type" "enum_page_templates_blocks_cwm_buttons_link_type" DEFAULT 'External',
	"link" varchar,
	"open_in_new_tab" boolean DEFAULT false,
	"is_primary" boolean
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_faq" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_faq_items" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_faq_items_locales" (
	"question" varchar NOT NULL,
	"answer" varchar NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_faq_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_features" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"columns" "enum_page_templates_blocks_features_columns" DEFAULT '3',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_features_features" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"icon_id" uuid
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_features_features_locales" (
	"title" varchar NOT NULL,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_features_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_hero" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"background_image_id" uuid,
	"cta_link" varchar,
	"secondary_cta_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_hero_locales" (
	"title" varchar NOT NULL,
	"subtitle" varchar,
	"description" jsonb,
	"cta_text" varchar,
	"secondary_cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_image" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"image_id" uuid NOT NULL,
	"alignment" "enum_page_templates_blocks_image_alignment" DEFAULT 'center',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_image_locales" (
	"caption" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_navbar" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"cta_url" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_navbar_links" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"url" varchar NOT NULL,
	"open_in_new_tab" boolean DEFAULT false
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_navbar_links_locales" (
	"label" varchar NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_navbar_locales" (
	"cta_label" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_site_footer" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_site_footer_sections" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_site_footer_sections_links" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"url" varchar NOT NULL,
	"open_in_new_tab" boolean DEFAULT false
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_site_footer_sections_links_locales" (
	"label" varchar NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_site_footer_sections_locales" (
	"title" varchar NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_stats" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"background_color" "enum_page_templates_blocks_stats_background_color" DEFAULT 'default',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_stats_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_stats_stats" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"value" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_stats_stats_locales" (
	"label" varchar NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_testimonials_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_testimonials_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"author_name" varchar NOT NULL,
	"author_image_id" uuid
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_testimonials_testimonials_locales" (
	"quote" varchar NOT NULL,
	"author_title" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_text" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"content_html" varchar,
	"alignment" "enum_page_templates_blocks_text_alignment" DEFAULT 'left',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "page_templates_blocks_text_locales" (
	"content" jsonb NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_templates_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"posts_id" uuid
);
--> statement-breakpoint
CREATE TABLE "pages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"slug" varchar,
	"status" "enum_pages_status" DEFAULT 'published',
	"page_template_id" uuid,
	"meta_canonical" varchar,
	"meta_site_name" varchar DEFAULT 'Human Maps',
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"_status" "enum_pages_status" DEFAULT 'draft'
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_10" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_10_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_2" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_2_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_3" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_3_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_4" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_4_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_5" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 5,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_5_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_6" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 6,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_6_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_7" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 3,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_7_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_8" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"max_posts" numeric DEFAULT 4,
	"view_all_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_8_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"view_all_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_index" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"posts_per_page" numeric DEFAULT 9,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_index_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_section" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"posts_limit" numeric DEFAULT 3,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_blog_section_locales" (
	"title" varchar,
	"subtitle" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_cta" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"button_link" varchar,
	"secondary_button_link" varchar,
	"background_color" "enum_pages_blocks_cta_background_color" DEFAULT 'default',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_cta_locales" (
	"title" varchar,
	"description" varchar,
	"button_text" varchar,
	"secondary_button_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_cwm" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"active" boolean DEFAULT true,
	"header_section_header_text" varchar,
	"header_section_header_level" "enum_pages_blocks_cwm_header_section_header_level" DEFAULT 'h2',
	"header_section_anchor" varchar,
	"image_image_id" uuid,
	"image_image_position" "enum_pages_blocks_cwm_image_image_position" DEFAULT 'backgroundCenter',
	"image_orientation" "enum_pages_blocks_cwm_image_orientation",
	"content" jsonb,
	"text_position" "enum_pages_blocks_cwm_text_position",
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_cwm_buttons" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"title" varchar,
	"link_type" "enum_pages_blocks_cwm_buttons_link_type" DEFAULT 'External',
	"link" varchar,
	"open_in_new_tab" boolean DEFAULT false,
	"is_primary" boolean
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_faq" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_faq_items" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_faq_items_locales" (
	"question" varchar,
	"answer" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_faq_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_features" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"columns" "enum_pages_blocks_features_columns" DEFAULT '3',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_features_features" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"icon_id" uuid
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_features_features_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_features_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_final_cta" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"button_link" varchar,
	"variant" "enum_pages_blocks_final_cta_variant" DEFAULT 'card',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_final_cta_locales" (
	"title" varchar,
	"description" varchar,
	"button_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_framework" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_framework_dimensions" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_framework_dimensions_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_framework_locales" (
	"badge" varchar,
	"title" varchar,
	"title_line2" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_hero" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"background_image_id" uuid,
	"cta_link" varchar,
	"secondary_cta_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_hero_locales" (
	"title" varchar,
	"subtitle" varchar,
	"description" jsonb,
	"cta_text" varchar,
	"secondary_cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_image" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"image_id" uuid,
	"alignment" "enum_pages_blocks_image_alignment" DEFAULT 'center',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_image_locales" (
	"caption" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_landing_hero" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"cta_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_landing_hero_locales" (
	"badge" varchar,
	"title" varchar,
	"subtitle" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_mechanism" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"cta_link" varchar,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_mechanism_locales" (
	"title" varchar,
	"description" varchar,
	"cta_text" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_mechanism_steps" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_mechanism_steps_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_pricing" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_pricing_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_stats" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"background_color" "enum_pages_blocks_stats_background_color" DEFAULT 'default',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_stats_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_stats_stats" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"value" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_stats_stats_locales" (
	"label" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_testimonials_locales" (
	"title" varchar,
	"subtitle" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_testimonials_testimonials" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"author_name" varchar,
	"author_image_id" uuid
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_testimonials_testimonials_locales" (
	"quote" varchar,
	"author_title" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_text" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"content_html" varchar,
	"alignment" "enum_pages_blocks_text_alignment" DEFAULT 'left',
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_text_locales" (
	"content" jsonb,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"_path" text NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"block_name" varchar
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is_cards" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is_cards_benefits" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is_cards_benefits_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is_cards_locales" (
	"badge" varchar,
	"title" varchar,
	"title_highlight" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_blocks_what_is_locales" (
	"title" varchar,
	"description" varchar,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_locales" (
	"title" varchar,
	"meta_title" varchar,
	"meta_description" varchar,
	"meta_image_id" uuid,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "pages_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"posts_id" uuid
);
--> statement-breakpoint
CREATE TABLE "payload_kv" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"key" varchar NOT NULL,
	"data" jsonb NOT NULL
);
--> statement-breakpoint
CREATE TABLE "payload_locked_documents" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"global_slug" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "payload_locked_documents_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"users_id" uuid,
	"user_sessions_id" uuid,
	"user_accounts_id" uuid,
	"user_verifications_id" uuid,
	"oauth_application_id" uuid,
	"oauth_access_token_id" uuid,
	"oauth_consent_id" uuid,
	"jwks_id" uuid,
	"user_subscriptions_id" varchar,
	"media_id" uuid,
	"categories_id" uuid,
	"posts_id" uuid,
	"pages_id" uuid,
	"page_templates_id" uuid
);
--> statement-breakpoint
CREATE TABLE "payload_migrations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar,
	"batch" numeric,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "payload_preferences" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"key" varchar,
	"value" jsonb,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "payload_preferences_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"users_id" uuid
);
--> statement-breakpoint
CREATE TABLE "plans" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"updated_at" timestamp(3) with time zone,
	"created_at" timestamp(3) with time zone
);
--> statement-breakpoint
CREATE TABLE "plans_plans" (
	"_order" integer NOT NULL,
	"_parent_id" uuid NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"key" varchar NOT NULL,
	"price" numeric NOT NULL,
	"product_key" varchar NOT NULL,
	"is_active" boolean DEFAULT true,
	"sort_order" numeric DEFAULT 0
);
--> statement-breakpoint
CREATE TABLE "plans_plans_features" (
	"_order" integer NOT NULL,
	"_parent_id" varchar NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"feature" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "plans_plans_locales" (
	"name" varchar NOT NULL,
	"description" varchar NOT NULL,
	"cta" varchar DEFAULT 'Get Started' NOT NULL,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE "posts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"status" "enum_posts_status" DEFAULT 'published',
	"featured" boolean DEFAULT false,
	"date" timestamp(3) with time zone,
	"link" varchar,
	"content_media_include_audio" boolean DEFAULT false,
	"content_media_include_video" boolean DEFAULT false,
	"content_media_audio" varchar,
	"content_media_video_host" "enum_posts_content_media_video_host" DEFAULT 'youtube',
	"content_media_youtube" varchar,
	"content_media_vimeo" varchar,
	"content_image_image_id" uuid,
	"content_image_image_position" "enum_posts_content_image_image_position" DEFAULT 'backgroundCenter',
	"content_richtext_html" varchar,
	"meta_canonical" varchar,
	"meta_site_name" varchar DEFAULT 'Human Maps',
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"_status" "enum_posts_status" DEFAULT 'draft'
);
--> statement-breakpoint
CREATE TABLE "posts_locales" (
	"title" varchar,
	"slug" varchar,
	"content_description" varchar,
	"content_summary" varchar,
	"content_rich_text" jsonb,
	"meta_title" varchar,
	"meta_description" varchar,
	"meta_image_id" uuid,
	"id" serial PRIMARY KEY NOT NULL,
	"_locale" "enum__locales" NOT NULL,
	"_parent_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE "posts_rels" (
	"id" serial PRIMARY KEY NOT NULL,
	"order" integer,
	"parent_id" uuid NOT NULL,
	"path" varchar NOT NULL,
	"users_id" uuid,
	"categories_id" uuid
);
--> statement-breakpoint
CREATE TABLE "user_accounts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id_id" uuid NOT NULL,
	"account_id" varchar NOT NULL,
	"provider_id" varchar NOT NULL,
	"access_token" varchar,
	"refresh_token" varchar,
	"access_token_expires_at" timestamp(3) with time zone,
	"refresh_token_expires_at" timestamp(3) with time zone,
	"scope" varchar,
	"id_token" varchar,
	"password" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id_id" uuid NOT NULL,
	"token" varchar NOT NULL,
	"expires_at" timestamp(3) with time zone NOT NULL,
	"ip_address" varchar,
	"user_agent" varchar,
	"impersonated_by" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_subscriptions" (
	"id" varchar PRIMARY KEY NOT NULL,
	"user_id_id" uuid,
	"amount" numeric NOT NULL,
	"currency" "enum_user_subscriptions_currency" NOT NULL,
	"recurring_interval" "enum_user_subscriptions_recurring_interval" NOT NULL,
	"status" "enum_user_subscriptions_status" NOT NULL,
	"current_period_start" timestamp(3) with time zone NOT NULL,
	"current_period_end" timestamp(3) with time zone NOT NULL,
	"cancel_at_period_end" boolean DEFAULT false,
	"canceled_at" timestamp(3) with time zone,
	"started_at" timestamp(3) with time zone NOT NULL,
	"ends_at" timestamp(3) with time zone,
	"ended_at" timestamp(3) with time zone,
	"customer_id" varchar NOT NULL,
	"product_id" varchar NOT NULL,
	"discount_id" varchar,
	"checkout_id" varchar NOT NULL,
	"customer_cancellation_reason" varchar,
	"customer_cancellation_comment" varchar,
	"modified_at" timestamp(3) with time zone,
	"metadata" varchar,
	"custom_field_data" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_verifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"identifier" varchar NOT NULL,
	"value" varchar NOT NULL,
	"expires_at" timestamp(3) with time zone NOT NULL,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"role" "enum_users_role" DEFAULT 'user' NOT NULL,
	"banned" boolean DEFAULT false,
	"ban_reason" varchar,
	"ban_expires" timestamp(3) with time zone,
	"email_verified" boolean DEFAULT false NOT NULL,
	"image" varchar,
	"updated_at" timestamp(3) with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp(3) with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "threads" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"subject" varchar(512) NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"modified_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "copilotkit_runs" ADD CONSTRAINT "copilotkit_runs_thread_id_threads_id_fk" FOREIGN KEY ("thread_id") REFERENCES "public"."threads"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v" ADD CONSTRAINT "_pages_v_parent_id_pages_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."pages"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v" ADD CONSTRAINT "_pages_v_version_page_template_id_page_templates_id_fk" FOREIGN KEY ("version_page_template_id") REFERENCES "public"."page_templates"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_10" ADD CONSTRAINT "_pages_v_blocks_blog_10_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_10_locales" ADD CONSTRAINT "_pages_v_blocks_blog_10_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_10"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_2" ADD CONSTRAINT "_pages_v_blocks_blog_2_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_2_locales" ADD CONSTRAINT "_pages_v_blocks_blog_2_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_2"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_3" ADD CONSTRAINT "_pages_v_blocks_blog_3_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_3_locales" ADD CONSTRAINT "_pages_v_blocks_blog_3_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_3"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_4" ADD CONSTRAINT "_pages_v_blocks_blog_4_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_4_locales" ADD CONSTRAINT "_pages_v_blocks_blog_4_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_4"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_5" ADD CONSTRAINT "_pages_v_blocks_blog_5_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_5_locales" ADD CONSTRAINT "_pages_v_blocks_blog_5_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_5"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_6" ADD CONSTRAINT "_pages_v_blocks_blog_6_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_6_locales" ADD CONSTRAINT "_pages_v_blocks_blog_6_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_6"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_7" ADD CONSTRAINT "_pages_v_blocks_blog_7_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_7_locales" ADD CONSTRAINT "_pages_v_blocks_blog_7_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_7"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_8" ADD CONSTRAINT "_pages_v_blocks_blog_8_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_8_locales" ADD CONSTRAINT "_pages_v_blocks_blog_8_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_8"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_index" ADD CONSTRAINT "_pages_v_blocks_blog_index_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_index_locales" ADD CONSTRAINT "_pages_v_blocks_blog_index_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_index"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_section" ADD CONSTRAINT "_pages_v_blocks_blog_section_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_blog_section_locales" ADD CONSTRAINT "_pages_v_blocks_blog_section_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_blog_section"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_cta" ADD CONSTRAINT "_pages_v_blocks_cta_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_cta_locales" ADD CONSTRAINT "_pages_v_blocks_cta_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_cta"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_cwm" ADD CONSTRAINT "_pages_v_blocks_cwm_image_image_id_media_id_fk" FOREIGN KEY ("image_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_cwm" ADD CONSTRAINT "_pages_v_blocks_cwm_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_cwm_buttons" ADD CONSTRAINT "_pages_v_blocks_cwm_buttons_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_cwm"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_faq" ADD CONSTRAINT "_pages_v_blocks_faq_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_faq_items" ADD CONSTRAINT "_pages_v_blocks_faq_items_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_faq_items_locales" ADD CONSTRAINT "_pages_v_blocks_faq_items_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_faq_items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_faq_locales" ADD CONSTRAINT "_pages_v_blocks_faq_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_features" ADD CONSTRAINT "_pages_v_blocks_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_features_features" ADD CONSTRAINT "_pages_v_blocks_features_features_icon_id_media_id_fk" FOREIGN KEY ("icon_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_features_features" ADD CONSTRAINT "_pages_v_blocks_features_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_features_features_locales" ADD CONSTRAINT "_pages_v_blocks_features_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_features_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_features_locales" ADD CONSTRAINT "_pages_v_blocks_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_final_cta" ADD CONSTRAINT "_pages_v_blocks_final_cta_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_final_cta_locales" ADD CONSTRAINT "_pages_v_blocks_final_cta_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_final_cta"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_framework" ADD CONSTRAINT "_pages_v_blocks_framework_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_framework_dimensions" ADD CONSTRAINT "_pages_v_blocks_framework_dimensions_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_framework"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_framework_dimensions_locales" ADD CONSTRAINT "_pages_v_blocks_framework_dimensions_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_framework_dimensions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_framework_locales" ADD CONSTRAINT "_pages_v_blocks_framework_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_framework"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_hero" ADD CONSTRAINT "_pages_v_blocks_hero_background_image_id_media_id_fk" FOREIGN KEY ("background_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_hero" ADD CONSTRAINT "_pages_v_blocks_hero_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_hero_locales" ADD CONSTRAINT "_pages_v_blocks_hero_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_hero"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_image" ADD CONSTRAINT "_pages_v_blocks_image_image_id_media_id_fk" FOREIGN KEY ("image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_image" ADD CONSTRAINT "_pages_v_blocks_image_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_image_locales" ADD CONSTRAINT "_pages_v_blocks_image_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_image"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_landing_hero" ADD CONSTRAINT "_pages_v_blocks_landing_hero_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_landing_hero_locales" ADD CONSTRAINT "_pages_v_blocks_landing_hero_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_landing_hero"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_mechanism" ADD CONSTRAINT "_pages_v_blocks_mechanism_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_mechanism_locales" ADD CONSTRAINT "_pages_v_blocks_mechanism_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_mechanism"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_mechanism_steps" ADD CONSTRAINT "_pages_v_blocks_mechanism_steps_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_mechanism"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_mechanism_steps_locales" ADD CONSTRAINT "_pages_v_blocks_mechanism_steps_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_mechanism_steps"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_pricing" ADD CONSTRAINT "_pages_v_blocks_pricing_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_pricing_locales" ADD CONSTRAINT "_pages_v_blocks_pricing_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_pricing"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_stats" ADD CONSTRAINT "_pages_v_blocks_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_stats_locales" ADD CONSTRAINT "_pages_v_blocks_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_stats_stats" ADD CONSTRAINT "_pages_v_blocks_stats_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_stats_stats_locales" ADD CONSTRAINT "_pages_v_blocks_stats_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_stats_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_testimonials" ADD CONSTRAINT "_pages_v_blocks_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_testimonials_locales" ADD CONSTRAINT "_pages_v_blocks_testimonials_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_testimonials_testimonials" ADD CONSTRAINT "_pages_v_blocks_testimonials_testimonials_author_image_id_media_id_fk" FOREIGN KEY ("author_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_testimonials_testimonials" ADD CONSTRAINT "_pages_v_blocks_testimonials_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_testimonials_testimonials_locales" ADD CONSTRAINT "_pages_v_blocks_testimonials_testimonials_locales_parent__fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_testimonials_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_text" ADD CONSTRAINT "_pages_v_blocks_text_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_text_locales" ADD CONSTRAINT "_pages_v_blocks_text_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_text"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is" ADD CONSTRAINT "_pages_v_blocks_what_is_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is_cards" ADD CONSTRAINT "_pages_v_blocks_what_is_cards_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_what_is"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is_cards_benefits" ADD CONSTRAINT "_pages_v_blocks_what_is_cards_benefits_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_what_is_cards"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is_cards_benefits_locales" ADD CONSTRAINT "_pages_v_blocks_what_is_cards_benefits_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_what_is_cards_benefits"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is_cards_locales" ADD CONSTRAINT "_pages_v_blocks_what_is_cards_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_what_is_cards"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_blocks_what_is_locales" ADD CONSTRAINT "_pages_v_blocks_what_is_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v_blocks_what_is"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_locales" ADD CONSTRAINT "_pages_v_locales_version_meta_image_id_media_id_fk" FOREIGN KEY ("version_meta_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_locales" ADD CONSTRAINT "_pages_v_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_rels" ADD CONSTRAINT "_pages_v_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."_pages_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_pages_v_rels" ADD CONSTRAINT "_pages_v_rels_posts_fk" FOREIGN KEY ("posts_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v" ADD CONSTRAINT "_posts_v_parent_id_posts_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."posts"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v" ADD CONSTRAINT "_posts_v_version_content_image_image_id_media_id_fk" FOREIGN KEY ("version_content_image_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v_locales" ADD CONSTRAINT "_posts_v_locales_version_meta_image_id_media_id_fk" FOREIGN KEY ("version_meta_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v_locales" ADD CONSTRAINT "_posts_v_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_posts_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v_rels" ADD CONSTRAINT "_posts_v_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."_posts_v"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v_rels" ADD CONSTRAINT "_posts_v_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "_posts_v_rels" ADD CONSTRAINT "_posts_v_rels_categories_fk" FOREIGN KEY ("categories_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "categories_locales" ADD CONSTRAINT "categories_locales_meta_image_id_media_id_fk" FOREIGN KEY ("meta_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "categories_locales" ADD CONSTRAINT "categories_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "global_settings" ADD CONSTRAINT "global_settings_logo_light_id_media_id_fk" FOREIGN KEY ("logo_light_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "global_settings" ADD CONSTRAINT "global_settings_logo_dark_id_media_id_fk" FOREIGN KEY ("logo_dark_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "global_settings_locales" ADD CONSTRAINT "global_settings_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."global_settings"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "global_settings_social_links" ADD CONSTRAINT "global_settings_social_links_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."global_settings"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "oauth_access_token" ADD CONSTRAINT "oauth_access_token_client_id_id_oauth_application_id_fk" FOREIGN KEY ("client_id_id") REFERENCES "public"."oauth_application"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "oauth_access_token" ADD CONSTRAINT "oauth_access_token_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "oauth_application" ADD CONSTRAINT "oauth_application_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "oauth_consent" ADD CONSTRAINT "oauth_consent_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "oauth_consent" ADD CONSTRAINT "oauth_consent_client_id_id_oauth_application_id_fk" FOREIGN KEY ("client_id_id") REFERENCES "public"."oauth_application"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_10" ADD CONSTRAINT "page_templates_blocks_blog_10_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_10_locales" ADD CONSTRAINT "page_templates_blocks_blog_10_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_10"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_2" ADD CONSTRAINT "page_templates_blocks_blog_2_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_2_locales" ADD CONSTRAINT "page_templates_blocks_blog_2_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_2"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_3" ADD CONSTRAINT "page_templates_blocks_blog_3_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_3_locales" ADD CONSTRAINT "page_templates_blocks_blog_3_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_3"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_4" ADD CONSTRAINT "page_templates_blocks_blog_4_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_4_locales" ADD CONSTRAINT "page_templates_blocks_blog_4_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_4"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_5" ADD CONSTRAINT "page_templates_blocks_blog_5_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_5_locales" ADD CONSTRAINT "page_templates_blocks_blog_5_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_5"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_6" ADD CONSTRAINT "page_templates_blocks_blog_6_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_6_locales" ADD CONSTRAINT "page_templates_blocks_blog_6_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_6"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_7" ADD CONSTRAINT "page_templates_blocks_blog_7_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_7_locales" ADD CONSTRAINT "page_templates_blocks_blog_7_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_7"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_8" ADD CONSTRAINT "page_templates_blocks_blog_8_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_blog_8_locales" ADD CONSTRAINT "page_templates_blocks_blog_8_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_blog_8"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_cta" ADD CONSTRAINT "page_templates_blocks_cta_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_cta_locales" ADD CONSTRAINT "page_templates_blocks_cta_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_cta"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_cwm" ADD CONSTRAINT "page_templates_blocks_cwm_image_image_id_media_id_fk" FOREIGN KEY ("image_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_cwm" ADD CONSTRAINT "page_templates_blocks_cwm_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_cwm_buttons" ADD CONSTRAINT "page_templates_blocks_cwm_buttons_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_cwm"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_faq" ADD CONSTRAINT "page_templates_blocks_faq_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_faq_items" ADD CONSTRAINT "page_templates_blocks_faq_items_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_faq_items_locales" ADD CONSTRAINT "page_templates_blocks_faq_items_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_faq_items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_faq_locales" ADD CONSTRAINT "page_templates_blocks_faq_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_features" ADD CONSTRAINT "page_templates_blocks_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_features_features" ADD CONSTRAINT "page_templates_blocks_features_features_icon_id_media_id_fk" FOREIGN KEY ("icon_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_features_features" ADD CONSTRAINT "page_templates_blocks_features_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_features_features_locales" ADD CONSTRAINT "page_templates_blocks_features_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_features_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_features_locales" ADD CONSTRAINT "page_templates_blocks_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_hero" ADD CONSTRAINT "page_templates_blocks_hero_background_image_id_media_id_fk" FOREIGN KEY ("background_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_hero" ADD CONSTRAINT "page_templates_blocks_hero_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_hero_locales" ADD CONSTRAINT "page_templates_blocks_hero_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_hero"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_image" ADD CONSTRAINT "page_templates_blocks_image_image_id_media_id_fk" FOREIGN KEY ("image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_image" ADD CONSTRAINT "page_templates_blocks_image_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_image_locales" ADD CONSTRAINT "page_templates_blocks_image_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_image"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_navbar" ADD CONSTRAINT "page_templates_blocks_navbar_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_navbar_links" ADD CONSTRAINT "page_templates_blocks_navbar_links_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_navbar"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_navbar_links_locales" ADD CONSTRAINT "page_templates_blocks_navbar_links_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_navbar_links"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_navbar_locales" ADD CONSTRAINT "page_templates_blocks_navbar_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_navbar"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_site_footer" ADD CONSTRAINT "page_templates_blocks_site_footer_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_site_footer_sections" ADD CONSTRAINT "page_templates_blocks_site_footer_sections_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_site_footer"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_site_footer_sections_links" ADD CONSTRAINT "page_templates_blocks_site_footer_sections_links_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_site_footer_sections"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_site_footer_sections_links_locales" ADD CONSTRAINT "page_templates_blocks_site_footer_sections_links_locales__fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_site_footer_sections_links"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_site_footer_sections_locales" ADD CONSTRAINT "page_templates_blocks_site_footer_sections_locales_parent_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_site_footer_sections"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_stats" ADD CONSTRAINT "page_templates_blocks_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_stats_locales" ADD CONSTRAINT "page_templates_blocks_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_stats_stats" ADD CONSTRAINT "page_templates_blocks_stats_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_stats_stats_locales" ADD CONSTRAINT "page_templates_blocks_stats_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_stats_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_testimonials" ADD CONSTRAINT "page_templates_blocks_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_testimonials_locales" ADD CONSTRAINT "page_templates_blocks_testimonials_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_testimonials_testimonials" ADD CONSTRAINT "page_templates_blocks_testimonials_testimonials_author_image_id_media_id_fk" FOREIGN KEY ("author_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_testimonials_testimonials" ADD CONSTRAINT "page_templates_blocks_testimonials_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_testimonials_testimonials_locales" ADD CONSTRAINT "page_templates_blocks_testimonials_testimonials_locales_p_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_testimonials_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_text" ADD CONSTRAINT "page_templates_blocks_text_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_blocks_text_locales" ADD CONSTRAINT "page_templates_blocks_text_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."page_templates_blocks_text"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_rels" ADD CONSTRAINT "page_templates_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "page_templates_rels" ADD CONSTRAINT "page_templates_rels_posts_fk" FOREIGN KEY ("posts_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages" ADD CONSTRAINT "pages_page_template_id_page_templates_id_fk" FOREIGN KEY ("page_template_id") REFERENCES "public"."page_templates"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_10" ADD CONSTRAINT "pages_blocks_blog_10_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_10_locales" ADD CONSTRAINT "pages_blocks_blog_10_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_10"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_2" ADD CONSTRAINT "pages_blocks_blog_2_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_2_locales" ADD CONSTRAINT "pages_blocks_blog_2_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_2"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_3" ADD CONSTRAINT "pages_blocks_blog_3_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_3_locales" ADD CONSTRAINT "pages_blocks_blog_3_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_3"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_4" ADD CONSTRAINT "pages_blocks_blog_4_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_4_locales" ADD CONSTRAINT "pages_blocks_blog_4_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_4"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_5" ADD CONSTRAINT "pages_blocks_blog_5_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_5_locales" ADD CONSTRAINT "pages_blocks_blog_5_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_5"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_6" ADD CONSTRAINT "pages_blocks_blog_6_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_6_locales" ADD CONSTRAINT "pages_blocks_blog_6_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_6"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_7" ADD CONSTRAINT "pages_blocks_blog_7_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_7_locales" ADD CONSTRAINT "pages_blocks_blog_7_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_7"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_8" ADD CONSTRAINT "pages_blocks_blog_8_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_8_locales" ADD CONSTRAINT "pages_blocks_blog_8_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_8"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_index" ADD CONSTRAINT "pages_blocks_blog_index_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_index_locales" ADD CONSTRAINT "pages_blocks_blog_index_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_index"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_section" ADD CONSTRAINT "pages_blocks_blog_section_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_blog_section_locales" ADD CONSTRAINT "pages_blocks_blog_section_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_blog_section"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_cta" ADD CONSTRAINT "pages_blocks_cta_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_cta_locales" ADD CONSTRAINT "pages_blocks_cta_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_cta"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_cwm" ADD CONSTRAINT "pages_blocks_cwm_image_image_id_media_id_fk" FOREIGN KEY ("image_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_cwm" ADD CONSTRAINT "pages_blocks_cwm_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_cwm_buttons" ADD CONSTRAINT "pages_blocks_cwm_buttons_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_cwm"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_faq" ADD CONSTRAINT "pages_blocks_faq_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_faq_items" ADD CONSTRAINT "pages_blocks_faq_items_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_faq_items_locales" ADD CONSTRAINT "pages_blocks_faq_items_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_faq_items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_faq_locales" ADD CONSTRAINT "pages_blocks_faq_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_faq"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_features" ADD CONSTRAINT "pages_blocks_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_features_features" ADD CONSTRAINT "pages_blocks_features_features_icon_id_media_id_fk" FOREIGN KEY ("icon_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_features_features" ADD CONSTRAINT "pages_blocks_features_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_features_features_locales" ADD CONSTRAINT "pages_blocks_features_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_features_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_features_locales" ADD CONSTRAINT "pages_blocks_features_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_features"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_final_cta" ADD CONSTRAINT "pages_blocks_final_cta_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_final_cta_locales" ADD CONSTRAINT "pages_blocks_final_cta_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_final_cta"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_framework" ADD CONSTRAINT "pages_blocks_framework_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_framework_dimensions" ADD CONSTRAINT "pages_blocks_framework_dimensions_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_framework"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_framework_dimensions_locales" ADD CONSTRAINT "pages_blocks_framework_dimensions_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_framework_dimensions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_framework_locales" ADD CONSTRAINT "pages_blocks_framework_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_framework"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_hero" ADD CONSTRAINT "pages_blocks_hero_background_image_id_media_id_fk" FOREIGN KEY ("background_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_hero" ADD CONSTRAINT "pages_blocks_hero_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_hero_locales" ADD CONSTRAINT "pages_blocks_hero_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_hero"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_image" ADD CONSTRAINT "pages_blocks_image_image_id_media_id_fk" FOREIGN KEY ("image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_image" ADD CONSTRAINT "pages_blocks_image_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_image_locales" ADD CONSTRAINT "pages_blocks_image_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_image"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_landing_hero" ADD CONSTRAINT "pages_blocks_landing_hero_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_landing_hero_locales" ADD CONSTRAINT "pages_blocks_landing_hero_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_landing_hero"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_mechanism" ADD CONSTRAINT "pages_blocks_mechanism_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_mechanism_locales" ADD CONSTRAINT "pages_blocks_mechanism_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_mechanism"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_mechanism_steps" ADD CONSTRAINT "pages_blocks_mechanism_steps_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_mechanism"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_mechanism_steps_locales" ADD CONSTRAINT "pages_blocks_mechanism_steps_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_mechanism_steps"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_pricing" ADD CONSTRAINT "pages_blocks_pricing_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_pricing_locales" ADD CONSTRAINT "pages_blocks_pricing_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_pricing"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_stats" ADD CONSTRAINT "pages_blocks_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_stats_locales" ADD CONSTRAINT "pages_blocks_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_stats_stats" ADD CONSTRAINT "pages_blocks_stats_stats_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_stats_stats_locales" ADD CONSTRAINT "pages_blocks_stats_stats_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_stats_stats"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_testimonials" ADD CONSTRAINT "pages_blocks_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_testimonials_locales" ADD CONSTRAINT "pages_blocks_testimonials_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_testimonials_testimonials" ADD CONSTRAINT "pages_blocks_testimonials_testimonials_author_image_id_media_id_fk" FOREIGN KEY ("author_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_testimonials_testimonials" ADD CONSTRAINT "pages_blocks_testimonials_testimonials_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_testimonials_testimonials_locales" ADD CONSTRAINT "pages_blocks_testimonials_testimonials_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_testimonials_testimonials"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_text" ADD CONSTRAINT "pages_blocks_text_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_text_locales" ADD CONSTRAINT "pages_blocks_text_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_text"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is" ADD CONSTRAINT "pages_blocks_what_is_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is_cards" ADD CONSTRAINT "pages_blocks_what_is_cards_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_what_is"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is_cards_benefits" ADD CONSTRAINT "pages_blocks_what_is_cards_benefits_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_what_is_cards"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is_cards_benefits_locales" ADD CONSTRAINT "pages_blocks_what_is_cards_benefits_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_what_is_cards_benefits"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is_cards_locales" ADD CONSTRAINT "pages_blocks_what_is_cards_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_what_is_cards"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_blocks_what_is_locales" ADD CONSTRAINT "pages_blocks_what_is_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages_blocks_what_is"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_locales" ADD CONSTRAINT "pages_locales_meta_image_id_media_id_fk" FOREIGN KEY ("meta_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_locales" ADD CONSTRAINT "pages_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_rels" ADD CONSTRAINT "pages_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "pages_rels" ADD CONSTRAINT "pages_rels_posts_fk" FOREIGN KEY ("posts_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."payload_locked_documents"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_user_sessions_fk" FOREIGN KEY ("user_sessions_id") REFERENCES "public"."user_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_user_accounts_fk" FOREIGN KEY ("user_accounts_id") REFERENCES "public"."user_accounts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_user_verifications_fk" FOREIGN KEY ("user_verifications_id") REFERENCES "public"."user_verifications"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_oauth_application_fk" FOREIGN KEY ("oauth_application_id") REFERENCES "public"."oauth_application"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_oauth_access_token_fk" FOREIGN KEY ("oauth_access_token_id") REFERENCES "public"."oauth_access_token"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_oauth_consent_fk" FOREIGN KEY ("oauth_consent_id") REFERENCES "public"."oauth_consent"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_jwks_fk" FOREIGN KEY ("jwks_id") REFERENCES "public"."jwks"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_user_subscriptions_fk" FOREIGN KEY ("user_subscriptions_id") REFERENCES "public"."user_subscriptions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_media_fk" FOREIGN KEY ("media_id") REFERENCES "public"."media"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_categories_fk" FOREIGN KEY ("categories_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_posts_fk" FOREIGN KEY ("posts_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_pages_fk" FOREIGN KEY ("pages_id") REFERENCES "public"."pages"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_locked_documents_rels" ADD CONSTRAINT "payload_locked_documents_rels_page_templates_fk" FOREIGN KEY ("page_templates_id") REFERENCES "public"."page_templates"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_preferences_rels" ADD CONSTRAINT "payload_preferences_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."payload_preferences"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payload_preferences_rels" ADD CONSTRAINT "payload_preferences_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plans_plans" ADD CONSTRAINT "plans_plans_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."plans"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plans_plans_features" ADD CONSTRAINT "plans_plans_features_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."plans_plans"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plans_plans_locales" ADD CONSTRAINT "plans_plans_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."plans_plans"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts" ADD CONSTRAINT "posts_content_image_image_id_media_id_fk" FOREIGN KEY ("content_image_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts_locales" ADD CONSTRAINT "posts_locales_meta_image_id_media_id_fk" FOREIGN KEY ("meta_image_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts_locales" ADD CONSTRAINT "posts_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts_rels" ADD CONSTRAINT "posts_rels_parent_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."posts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts_rels" ADD CONSTRAINT "posts_rels_users_fk" FOREIGN KEY ("users_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "posts_rels" ADD CONSTRAINT "posts_rels_categories_fk" FOREIGN KEY ("categories_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_accounts" ADD CONSTRAINT "user_accounts_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_subscriptions" ADD CONSTRAINT "user_subscriptions_user_id_id_users_id_fk" FOREIGN KEY ("user_id_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "_pages_v_parent_idx" ON "_pages_v" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_version_version_slug_idx" ON "_pages_v" USING btree ("version_slug");--> statement-breakpoint
CREATE INDEX "_pages_v_version_version_page_template_idx" ON "_pages_v" USING btree ("version_page_template_id");--> statement-breakpoint
CREATE INDEX "_pages_v_version_version_updated_at_idx" ON "_pages_v" USING btree ("version_updated_at");--> statement-breakpoint
CREATE INDEX "_pages_v_version_version_created_at_idx" ON "_pages_v" USING btree ("version_created_at");--> statement-breakpoint
CREATE INDEX "_pages_v_version_version__status_idx" ON "_pages_v" USING btree ("version__status");--> statement-breakpoint
CREATE INDEX "_pages_v_created_at_idx" ON "_pages_v" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "_pages_v_updated_at_idx" ON "_pages_v" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "_pages_v_snapshot_idx" ON "_pages_v" USING btree ("snapshot");--> statement-breakpoint
CREATE INDEX "_pages_v_published_locale_idx" ON "_pages_v" USING btree ("published_locale");--> statement-breakpoint
CREATE INDEX "_pages_v_latest_idx" ON "_pages_v" USING btree ("latest");--> statement-breakpoint
CREATE INDEX "_pages_v_autosave_idx" ON "_pages_v" USING btree ("autosave");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_10_order_idx" ON "_pages_v_blocks_blog_10" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_10_parent_id_idx" ON "_pages_v_blocks_blog_10" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_10_path_idx" ON "_pages_v_blocks_blog_10" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_10_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_10_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_2_order_idx" ON "_pages_v_blocks_blog_2" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_2_parent_id_idx" ON "_pages_v_blocks_blog_2" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_2_path_idx" ON "_pages_v_blocks_blog_2" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_2_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_2_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_3_order_idx" ON "_pages_v_blocks_blog_3" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_3_parent_id_idx" ON "_pages_v_blocks_blog_3" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_3_path_idx" ON "_pages_v_blocks_blog_3" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_3_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_3_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_4_order_idx" ON "_pages_v_blocks_blog_4" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_4_parent_id_idx" ON "_pages_v_blocks_blog_4" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_4_path_idx" ON "_pages_v_blocks_blog_4" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_4_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_4_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_5_order_idx" ON "_pages_v_blocks_blog_5" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_5_parent_id_idx" ON "_pages_v_blocks_blog_5" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_5_path_idx" ON "_pages_v_blocks_blog_5" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_5_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_5_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_6_order_idx" ON "_pages_v_blocks_blog_6" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_6_parent_id_idx" ON "_pages_v_blocks_blog_6" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_6_path_idx" ON "_pages_v_blocks_blog_6" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_6_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_6_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_7_order_idx" ON "_pages_v_blocks_blog_7" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_7_parent_id_idx" ON "_pages_v_blocks_blog_7" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_7_path_idx" ON "_pages_v_blocks_blog_7" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_7_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_7_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_8_order_idx" ON "_pages_v_blocks_blog_8" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_8_parent_id_idx" ON "_pages_v_blocks_blog_8" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_8_path_idx" ON "_pages_v_blocks_blog_8" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_8_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_8_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_index_order_idx" ON "_pages_v_blocks_blog_index" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_index_parent_id_idx" ON "_pages_v_blocks_blog_index" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_index_path_idx" ON "_pages_v_blocks_blog_index" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_index_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_index_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_section_order_idx" ON "_pages_v_blocks_blog_section" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_section_parent_id_idx" ON "_pages_v_blocks_blog_section" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_blog_section_path_idx" ON "_pages_v_blocks_blog_section" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_blog_section_locales_locale_parent_id_unique" ON "_pages_v_blocks_blog_section_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cta_order_idx" ON "_pages_v_blocks_cta" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cta_parent_id_idx" ON "_pages_v_blocks_cta" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cta_path_idx" ON "_pages_v_blocks_cta" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_cta_locales_locale_parent_id_unique" ON "_pages_v_blocks_cta_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_order_idx" ON "_pages_v_blocks_cwm" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_parent_id_idx" ON "_pages_v_blocks_cwm" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_path_idx" ON "_pages_v_blocks_cwm" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_image_image_image_idx" ON "_pages_v_blocks_cwm" USING btree ("image_image_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_buttons_order_idx" ON "_pages_v_blocks_cwm_buttons" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_cwm_buttons_parent_id_idx" ON "_pages_v_blocks_cwm_buttons" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_faq_order_idx" ON "_pages_v_blocks_faq" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_faq_parent_id_idx" ON "_pages_v_blocks_faq" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_faq_path_idx" ON "_pages_v_blocks_faq" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_faq_items_order_idx" ON "_pages_v_blocks_faq_items" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_faq_items_parent_id_idx" ON "_pages_v_blocks_faq_items" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_faq_items_locales_locale_parent_id_unique" ON "_pages_v_blocks_faq_items_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_faq_locales_locale_parent_id_unique" ON "_pages_v_blocks_faq_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_order_idx" ON "_pages_v_blocks_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_parent_id_idx" ON "_pages_v_blocks_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_path_idx" ON "_pages_v_blocks_features" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_features_order_idx" ON "_pages_v_blocks_features_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_features_parent_id_idx" ON "_pages_v_blocks_features_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_features_features_icon_idx" ON "_pages_v_blocks_features_features" USING btree ("icon_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_features_features_locales_locale_parent_id_u" ON "_pages_v_blocks_features_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_features_locales_locale_parent_id_unique" ON "_pages_v_blocks_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_final_cta_order_idx" ON "_pages_v_blocks_final_cta" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_final_cta_parent_id_idx" ON "_pages_v_blocks_final_cta" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_final_cta_path_idx" ON "_pages_v_blocks_final_cta" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_final_cta_locales_locale_parent_id_unique" ON "_pages_v_blocks_final_cta_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_framework_order_idx" ON "_pages_v_blocks_framework" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_framework_parent_id_idx" ON "_pages_v_blocks_framework" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_framework_path_idx" ON "_pages_v_blocks_framework" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_framework_dimensions_order_idx" ON "_pages_v_blocks_framework_dimensions" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_framework_dimensions_parent_id_idx" ON "_pages_v_blocks_framework_dimensions" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_framework_dimensions_locales_locale_parent_i" ON "_pages_v_blocks_framework_dimensions_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_framework_locales_locale_parent_id_unique" ON "_pages_v_blocks_framework_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_hero_order_idx" ON "_pages_v_blocks_hero" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_hero_parent_id_idx" ON "_pages_v_blocks_hero" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_hero_path_idx" ON "_pages_v_blocks_hero" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_hero_background_image_idx" ON "_pages_v_blocks_hero" USING btree ("background_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_hero_locales_locale_parent_id_unique" ON "_pages_v_blocks_hero_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_image_order_idx" ON "_pages_v_blocks_image" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_image_parent_id_idx" ON "_pages_v_blocks_image" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_image_path_idx" ON "_pages_v_blocks_image" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_image_image_idx" ON "_pages_v_blocks_image" USING btree ("image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_image_locales_locale_parent_id_unique" ON "_pages_v_blocks_image_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_landing_hero_order_idx" ON "_pages_v_blocks_landing_hero" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_landing_hero_parent_id_idx" ON "_pages_v_blocks_landing_hero" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_landing_hero_path_idx" ON "_pages_v_blocks_landing_hero" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_landing_hero_locales_locale_parent_id_unique" ON "_pages_v_blocks_landing_hero_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_mechanism_order_idx" ON "_pages_v_blocks_mechanism" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_mechanism_parent_id_idx" ON "_pages_v_blocks_mechanism" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_mechanism_path_idx" ON "_pages_v_blocks_mechanism" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_mechanism_locales_locale_parent_id_unique" ON "_pages_v_blocks_mechanism_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_mechanism_steps_order_idx" ON "_pages_v_blocks_mechanism_steps" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_mechanism_steps_parent_id_idx" ON "_pages_v_blocks_mechanism_steps" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_mechanism_steps_locales_locale_parent_id_uni" ON "_pages_v_blocks_mechanism_steps_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_pricing_order_idx" ON "_pages_v_blocks_pricing" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_pricing_parent_id_idx" ON "_pages_v_blocks_pricing" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_pricing_path_idx" ON "_pages_v_blocks_pricing" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_pricing_locales_locale_parent_id_unique" ON "_pages_v_blocks_pricing_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_stats_order_idx" ON "_pages_v_blocks_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_stats_parent_id_idx" ON "_pages_v_blocks_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_stats_path_idx" ON "_pages_v_blocks_stats" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_stats_locales_locale_parent_id_unique" ON "_pages_v_blocks_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_stats_stats_order_idx" ON "_pages_v_blocks_stats_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_stats_stats_parent_id_idx" ON "_pages_v_blocks_stats_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_stats_stats_locales_locale_parent_id_unique" ON "_pages_v_blocks_stats_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_order_idx" ON "_pages_v_blocks_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_parent_id_idx" ON "_pages_v_blocks_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_path_idx" ON "_pages_v_blocks_testimonials" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_testimonials_locales_locale_parent_id_unique" ON "_pages_v_blocks_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_testimonials_order_idx" ON "_pages_v_blocks_testimonials_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_testimonials_parent_id_idx" ON "_pages_v_blocks_testimonials_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_testimonials_testimonials_author_image_idx" ON "_pages_v_blocks_testimonials_testimonials" USING btree ("author_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_testimonials_testimonials_locales_locale_par" ON "_pages_v_blocks_testimonials_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_text_order_idx" ON "_pages_v_blocks_text" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_text_parent_id_idx" ON "_pages_v_blocks_text" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_text_path_idx" ON "_pages_v_blocks_text" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_text_locales_locale_parent_id_unique" ON "_pages_v_blocks_text_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_order_idx" ON "_pages_v_blocks_what_is" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_parent_id_idx" ON "_pages_v_blocks_what_is" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_path_idx" ON "_pages_v_blocks_what_is" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_cards_order_idx" ON "_pages_v_blocks_what_is_cards" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_cards_parent_id_idx" ON "_pages_v_blocks_what_is_cards" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_cards_benefits_order_idx" ON "_pages_v_blocks_what_is_cards_benefits" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "_pages_v_blocks_what_is_cards_benefits_parent_id_idx" ON "_pages_v_blocks_what_is_cards_benefits" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_what_is_cards_benefits_locales_locale_parent" ON "_pages_v_blocks_what_is_cards_benefits_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_what_is_cards_locales_locale_parent_id_uniqu" ON "_pages_v_blocks_what_is_cards_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_blocks_what_is_locales_locale_parent_id_unique" ON "_pages_v_blocks_what_is_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_version_meta_version_meta_image_idx" ON "_pages_v_locales" USING btree ("version_meta_image_id","_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "_pages_v_locales_locale_parent_id_unique" ON "_pages_v_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_rels_order_idx" ON "_pages_v_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "_pages_v_rels_parent_idx" ON "_pages_v_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "_pages_v_rels_path_idx" ON "_pages_v_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "_pages_v_rels_posts_id_idx" ON "_pages_v_rels" USING btree ("posts_id");--> statement-breakpoint
CREATE INDEX "_posts_v_parent_idx" ON "_posts_v" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "_posts_v_version_content_image_version_content_image_ima_idx" ON "_posts_v" USING btree ("version_content_image_image_id");--> statement-breakpoint
CREATE INDEX "_posts_v_version_version_updated_at_idx" ON "_posts_v" USING btree ("version_updated_at");--> statement-breakpoint
CREATE INDEX "_posts_v_version_version_created_at_idx" ON "_posts_v" USING btree ("version_created_at");--> statement-breakpoint
CREATE INDEX "_posts_v_version_version__status_idx" ON "_posts_v" USING btree ("version__status");--> statement-breakpoint
CREATE INDEX "_posts_v_created_at_idx" ON "_posts_v" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "_posts_v_updated_at_idx" ON "_posts_v" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "_posts_v_snapshot_idx" ON "_posts_v" USING btree ("snapshot");--> statement-breakpoint
CREATE INDEX "_posts_v_published_locale_idx" ON "_posts_v" USING btree ("published_locale");--> statement-breakpoint
CREATE INDEX "_posts_v_latest_idx" ON "_posts_v" USING btree ("latest");--> statement-breakpoint
CREATE INDEX "_posts_v_autosave_idx" ON "_posts_v" USING btree ("autosave");--> statement-breakpoint
CREATE INDEX "_posts_v_version_version_slug_idx" ON "_posts_v_locales" USING btree ("version_slug","_locale");--> statement-breakpoint
CREATE INDEX "_posts_v_version_meta_version_meta_image_idx" ON "_posts_v_locales" USING btree ("version_meta_image_id","_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "_posts_v_locales_locale_parent_id_unique" ON "_posts_v_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "_posts_v_rels_order_idx" ON "_posts_v_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "_posts_v_rels_parent_idx" ON "_posts_v_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "_posts_v_rels_path_idx" ON "_posts_v_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "_posts_v_rels_users_id_idx" ON "_posts_v_rels" USING btree ("users_id");--> statement-breakpoint
CREATE INDEX "_posts_v_rels_categories_id_idx" ON "_posts_v_rels" USING btree ("categories_id");--> statement-breakpoint
CREATE UNIQUE INDEX "categories_slug_idx" ON "categories" USING btree ("slug");--> statement-breakpoint
CREATE INDEX "categories_updated_at_idx" ON "categories" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "categories_created_at_idx" ON "categories" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "categories_meta_meta_image_idx" ON "categories_locales" USING btree ("meta_image_id","_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "categories_locales_locale_parent_id_unique" ON "categories_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "global_settings_logo_logo_light_idx" ON "global_settings" USING btree ("logo_light_id");--> statement-breakpoint
CREATE INDEX "global_settings_logo_logo_dark_idx" ON "global_settings" USING btree ("logo_dark_id");--> statement-breakpoint
CREATE UNIQUE INDEX "global_settings_locales_locale_parent_id_unique" ON "global_settings_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "global_settings_social_links_order_idx" ON "global_settings_social_links" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "global_settings_social_links_parent_id_idx" ON "global_settings_social_links" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "jwks_expires_at_idx" ON "jwks" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "jwks_updated_at_idx" ON "jwks" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "jwks_created_at_idx" ON "jwks" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "media_updated_at_idx" ON "media" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "media_created_at_idx" ON "media" USING btree ("created_at");--> statement-breakpoint
CREATE UNIQUE INDEX "media_filename_idx" ON "media" USING btree ("filename");--> statement-breakpoint
CREATE UNIQUE INDEX "oauth_access_token_access_token_idx" ON "oauth_access_token" USING btree ("access_token");--> statement-breakpoint
CREATE UNIQUE INDEX "oauth_access_token_refresh_token_idx" ON "oauth_access_token" USING btree ("refresh_token");--> statement-breakpoint
CREATE INDEX "oauth_access_token_client_id_idx" ON "oauth_access_token" USING btree ("client_id_id");--> statement-breakpoint
CREATE INDEX "oauth_access_token_user_id_idx" ON "oauth_access_token" USING btree ("user_id_id");--> statement-breakpoint
CREATE INDEX "oauth_access_token_updated_at_idx" ON "oauth_access_token" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "oauth_access_token_created_at_idx" ON "oauth_access_token" USING btree ("created_at");--> statement-breakpoint
CREATE UNIQUE INDEX "oauth_application_client_id_idx" ON "oauth_application" USING btree ("client_id");--> statement-breakpoint
CREATE INDEX "oauth_application_user_id_idx" ON "oauth_application" USING btree ("user_id_id");--> statement-breakpoint
CREATE INDEX "oauth_application_updated_at_idx" ON "oauth_application" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "oauth_application_created_at_idx" ON "oauth_application" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "oauth_consent_user_id_idx" ON "oauth_consent" USING btree ("user_id_id");--> statement-breakpoint
CREATE INDEX "oauth_consent_client_id_idx" ON "oauth_consent" USING btree ("client_id_id");--> statement-breakpoint
CREATE INDEX "oauth_consent_updated_at_idx" ON "oauth_consent" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "oauth_consent_created_at_idx" ON "oauth_consent" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "page_templates_updated_at_idx" ON "page_templates" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "page_templates_created_at_idx" ON "page_templates" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_10_order_idx" ON "page_templates_blocks_blog_10" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_10_parent_id_idx" ON "page_templates_blocks_blog_10" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_10_path_idx" ON "page_templates_blocks_blog_10" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_10_locales_locale_parent_id_uniqu" ON "page_templates_blocks_blog_10_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_2_order_idx" ON "page_templates_blocks_blog_2" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_2_parent_id_idx" ON "page_templates_blocks_blog_2" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_2_path_idx" ON "page_templates_blocks_blog_2" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_2_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_2_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_3_order_idx" ON "page_templates_blocks_blog_3" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_3_parent_id_idx" ON "page_templates_blocks_blog_3" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_3_path_idx" ON "page_templates_blocks_blog_3" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_3_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_3_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_4_order_idx" ON "page_templates_blocks_blog_4" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_4_parent_id_idx" ON "page_templates_blocks_blog_4" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_4_path_idx" ON "page_templates_blocks_blog_4" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_4_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_4_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_5_order_idx" ON "page_templates_blocks_blog_5" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_5_parent_id_idx" ON "page_templates_blocks_blog_5" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_5_path_idx" ON "page_templates_blocks_blog_5" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_5_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_5_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_6_order_idx" ON "page_templates_blocks_blog_6" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_6_parent_id_idx" ON "page_templates_blocks_blog_6" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_6_path_idx" ON "page_templates_blocks_blog_6" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_6_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_6_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_7_order_idx" ON "page_templates_blocks_blog_7" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_7_parent_id_idx" ON "page_templates_blocks_blog_7" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_7_path_idx" ON "page_templates_blocks_blog_7" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_7_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_7_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_8_order_idx" ON "page_templates_blocks_blog_8" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_8_parent_id_idx" ON "page_templates_blocks_blog_8" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_blog_8_path_idx" ON "page_templates_blocks_blog_8" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_blog_8_locales_locale_parent_id_unique" ON "page_templates_blocks_blog_8_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cta_order_idx" ON "page_templates_blocks_cta" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cta_parent_id_idx" ON "page_templates_blocks_cta" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cta_path_idx" ON "page_templates_blocks_cta" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_cta_locales_locale_parent_id_unique" ON "page_templates_blocks_cta_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_order_idx" ON "page_templates_blocks_cwm" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_parent_id_idx" ON "page_templates_blocks_cwm" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_path_idx" ON "page_templates_blocks_cwm" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_image_image_image_idx" ON "page_templates_blocks_cwm" USING btree ("image_image_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_buttons_order_idx" ON "page_templates_blocks_cwm_buttons" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_cwm_buttons_parent_id_idx" ON "page_templates_blocks_cwm_buttons" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_faq_order_idx" ON "page_templates_blocks_faq" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_faq_parent_id_idx" ON "page_templates_blocks_faq" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_faq_path_idx" ON "page_templates_blocks_faq" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_faq_items_order_idx" ON "page_templates_blocks_faq_items" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_faq_items_parent_id_idx" ON "page_templates_blocks_faq_items" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_faq_items_locales_locale_parent_id_uni" ON "page_templates_blocks_faq_items_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_faq_locales_locale_parent_id_unique" ON "page_templates_blocks_faq_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_order_idx" ON "page_templates_blocks_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_parent_id_idx" ON "page_templates_blocks_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_path_idx" ON "page_templates_blocks_features" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_features_order_idx" ON "page_templates_blocks_features_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_features_parent_id_idx" ON "page_templates_blocks_features_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_features_features_icon_idx" ON "page_templates_blocks_features_features" USING btree ("icon_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_features_features_locales_locale_paren" ON "page_templates_blocks_features_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_features_locales_locale_parent_id_uniq" ON "page_templates_blocks_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_hero_order_idx" ON "page_templates_blocks_hero" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_hero_parent_id_idx" ON "page_templates_blocks_hero" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_hero_path_idx" ON "page_templates_blocks_hero" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_hero_background_image_idx" ON "page_templates_blocks_hero" USING btree ("background_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_hero_locales_locale_parent_id_unique" ON "page_templates_blocks_hero_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_image_order_idx" ON "page_templates_blocks_image" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_image_parent_id_idx" ON "page_templates_blocks_image" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_image_path_idx" ON "page_templates_blocks_image" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_image_image_idx" ON "page_templates_blocks_image" USING btree ("image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_image_locales_locale_parent_id_unique" ON "page_templates_blocks_image_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_navbar_order_idx" ON "page_templates_blocks_navbar" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_navbar_parent_id_idx" ON "page_templates_blocks_navbar" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_navbar_path_idx" ON "page_templates_blocks_navbar" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_navbar_links_order_idx" ON "page_templates_blocks_navbar_links" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_navbar_links_parent_id_idx" ON "page_templates_blocks_navbar_links" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_navbar_links_locales_locale_parent_id_" ON "page_templates_blocks_navbar_links_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_navbar_locales_locale_parent_id_unique" ON "page_templates_blocks_navbar_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_order_idx" ON "page_templates_blocks_site_footer" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_parent_id_idx" ON "page_templates_blocks_site_footer" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_path_idx" ON "page_templates_blocks_site_footer" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_sections_order_idx" ON "page_templates_blocks_site_footer_sections" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_sections_parent_id_idx" ON "page_templates_blocks_site_footer_sections" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_sections_links_order_idx" ON "page_templates_blocks_site_footer_sections_links" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_site_footer_sections_links_parent_id_idx" ON "page_templates_blocks_site_footer_sections_links" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_site_footer_sections_links_locales_loc" ON "page_templates_blocks_site_footer_sections_links_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_site_footer_sections_locales_locale_pa" ON "page_templates_blocks_site_footer_sections_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_stats_order_idx" ON "page_templates_blocks_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_stats_parent_id_idx" ON "page_templates_blocks_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_stats_path_idx" ON "page_templates_blocks_stats" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_stats_locales_locale_parent_id_unique" ON "page_templates_blocks_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_stats_stats_order_idx" ON "page_templates_blocks_stats_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_stats_stats_parent_id_idx" ON "page_templates_blocks_stats_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_stats_stats_locales_locale_parent_id_u" ON "page_templates_blocks_stats_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_order_idx" ON "page_templates_blocks_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_parent_id_idx" ON "page_templates_blocks_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_path_idx" ON "page_templates_blocks_testimonials" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_testimonials_locales_locale_parent_id_" ON "page_templates_blocks_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_testimonials_order_idx" ON "page_templates_blocks_testimonials_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_testimonials_parent_id_idx" ON "page_templates_blocks_testimonials_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_testimonials_testimonials_author_i_idx" ON "page_templates_blocks_testimonials_testimonials" USING btree ("author_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_testimonials_testimonials_locales_loca" ON "page_templates_blocks_testimonials_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_text_order_idx" ON "page_templates_blocks_text" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_text_parent_id_idx" ON "page_templates_blocks_text" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_blocks_text_path_idx" ON "page_templates_blocks_text" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "page_templates_blocks_text_locales_locale_parent_id_unique" ON "page_templates_blocks_text_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_rels_order_idx" ON "page_templates_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "page_templates_rels_parent_idx" ON "page_templates_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "page_templates_rels_path_idx" ON "page_templates_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "page_templates_rels_posts_id_idx" ON "page_templates_rels" USING btree ("posts_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_slug_idx" ON "pages" USING btree ("slug");--> statement-breakpoint
CREATE INDEX "pages_page_template_idx" ON "pages" USING btree ("page_template_id");--> statement-breakpoint
CREATE INDEX "pages_updated_at_idx" ON "pages" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "pages_created_at_idx" ON "pages" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "pages__status_idx" ON "pages" USING btree ("_status");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_10_order_idx" ON "pages_blocks_blog_10" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_10_parent_id_idx" ON "pages_blocks_blog_10" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_10_path_idx" ON "pages_blocks_blog_10" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_10_locales_locale_parent_id_unique" ON "pages_blocks_blog_10_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_2_order_idx" ON "pages_blocks_blog_2" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_2_parent_id_idx" ON "pages_blocks_blog_2" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_2_path_idx" ON "pages_blocks_blog_2" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_2_locales_locale_parent_id_unique" ON "pages_blocks_blog_2_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_3_order_idx" ON "pages_blocks_blog_3" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_3_parent_id_idx" ON "pages_blocks_blog_3" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_3_path_idx" ON "pages_blocks_blog_3" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_3_locales_locale_parent_id_unique" ON "pages_blocks_blog_3_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_4_order_idx" ON "pages_blocks_blog_4" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_4_parent_id_idx" ON "pages_blocks_blog_4" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_4_path_idx" ON "pages_blocks_blog_4" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_4_locales_locale_parent_id_unique" ON "pages_blocks_blog_4_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_5_order_idx" ON "pages_blocks_blog_5" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_5_parent_id_idx" ON "pages_blocks_blog_5" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_5_path_idx" ON "pages_blocks_blog_5" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_5_locales_locale_parent_id_unique" ON "pages_blocks_blog_5_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_6_order_idx" ON "pages_blocks_blog_6" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_6_parent_id_idx" ON "pages_blocks_blog_6" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_6_path_idx" ON "pages_blocks_blog_6" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_6_locales_locale_parent_id_unique" ON "pages_blocks_blog_6_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_7_order_idx" ON "pages_blocks_blog_7" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_7_parent_id_idx" ON "pages_blocks_blog_7" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_7_path_idx" ON "pages_blocks_blog_7" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_7_locales_locale_parent_id_unique" ON "pages_blocks_blog_7_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_8_order_idx" ON "pages_blocks_blog_8" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_8_parent_id_idx" ON "pages_blocks_blog_8" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_8_path_idx" ON "pages_blocks_blog_8" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_8_locales_locale_parent_id_unique" ON "pages_blocks_blog_8_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_index_order_idx" ON "pages_blocks_blog_index" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_index_parent_id_idx" ON "pages_blocks_blog_index" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_index_path_idx" ON "pages_blocks_blog_index" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_index_locales_locale_parent_id_unique" ON "pages_blocks_blog_index_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_section_order_idx" ON "pages_blocks_blog_section" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_section_parent_id_idx" ON "pages_blocks_blog_section" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_blog_section_path_idx" ON "pages_blocks_blog_section" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_blog_section_locales_locale_parent_id_unique" ON "pages_blocks_blog_section_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_cta_order_idx" ON "pages_blocks_cta" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_cta_parent_id_idx" ON "pages_blocks_cta" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_cta_path_idx" ON "pages_blocks_cta" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_cta_locales_locale_parent_id_unique" ON "pages_blocks_cta_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_order_idx" ON "pages_blocks_cwm" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_parent_id_idx" ON "pages_blocks_cwm" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_path_idx" ON "pages_blocks_cwm" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_image_image_image_idx" ON "pages_blocks_cwm" USING btree ("image_image_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_buttons_order_idx" ON "pages_blocks_cwm_buttons" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_cwm_buttons_parent_id_idx" ON "pages_blocks_cwm_buttons" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_faq_order_idx" ON "pages_blocks_faq" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_faq_parent_id_idx" ON "pages_blocks_faq" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_faq_path_idx" ON "pages_blocks_faq" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_faq_items_order_idx" ON "pages_blocks_faq_items" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_faq_items_parent_id_idx" ON "pages_blocks_faq_items" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_faq_items_locales_locale_parent_id_unique" ON "pages_blocks_faq_items_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_faq_locales_locale_parent_id_unique" ON "pages_blocks_faq_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_order_idx" ON "pages_blocks_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_parent_id_idx" ON "pages_blocks_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_path_idx" ON "pages_blocks_features" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_features_order_idx" ON "pages_blocks_features_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_features_parent_id_idx" ON "pages_blocks_features_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_features_features_icon_idx" ON "pages_blocks_features_features" USING btree ("icon_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_features_features_locales_locale_parent_id_uniq" ON "pages_blocks_features_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_features_locales_locale_parent_id_unique" ON "pages_blocks_features_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_final_cta_order_idx" ON "pages_blocks_final_cta" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_final_cta_parent_id_idx" ON "pages_blocks_final_cta" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_final_cta_path_idx" ON "pages_blocks_final_cta" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_final_cta_locales_locale_parent_id_unique" ON "pages_blocks_final_cta_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_framework_order_idx" ON "pages_blocks_framework" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_framework_parent_id_idx" ON "pages_blocks_framework" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_framework_path_idx" ON "pages_blocks_framework" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_framework_dimensions_order_idx" ON "pages_blocks_framework_dimensions" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_framework_dimensions_parent_id_idx" ON "pages_blocks_framework_dimensions" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_framework_dimensions_locales_locale_parent_id_u" ON "pages_blocks_framework_dimensions_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_framework_locales_locale_parent_id_unique" ON "pages_blocks_framework_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_hero_order_idx" ON "pages_blocks_hero" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_hero_parent_id_idx" ON "pages_blocks_hero" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_hero_path_idx" ON "pages_blocks_hero" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_hero_background_image_idx" ON "pages_blocks_hero" USING btree ("background_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_hero_locales_locale_parent_id_unique" ON "pages_blocks_hero_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_image_order_idx" ON "pages_blocks_image" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_image_parent_id_idx" ON "pages_blocks_image" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_image_path_idx" ON "pages_blocks_image" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_image_image_idx" ON "pages_blocks_image" USING btree ("image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_image_locales_locale_parent_id_unique" ON "pages_blocks_image_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_landing_hero_order_idx" ON "pages_blocks_landing_hero" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_landing_hero_parent_id_idx" ON "pages_blocks_landing_hero" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_landing_hero_path_idx" ON "pages_blocks_landing_hero" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_landing_hero_locales_locale_parent_id_unique" ON "pages_blocks_landing_hero_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_mechanism_order_idx" ON "pages_blocks_mechanism" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_mechanism_parent_id_idx" ON "pages_blocks_mechanism" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_mechanism_path_idx" ON "pages_blocks_mechanism" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_mechanism_locales_locale_parent_id_unique" ON "pages_blocks_mechanism_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_mechanism_steps_order_idx" ON "pages_blocks_mechanism_steps" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_mechanism_steps_parent_id_idx" ON "pages_blocks_mechanism_steps" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_mechanism_steps_locales_locale_parent_id_unique" ON "pages_blocks_mechanism_steps_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_pricing_order_idx" ON "pages_blocks_pricing" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_pricing_parent_id_idx" ON "pages_blocks_pricing" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_pricing_path_idx" ON "pages_blocks_pricing" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_pricing_locales_locale_parent_id_unique" ON "pages_blocks_pricing_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_stats_order_idx" ON "pages_blocks_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_stats_parent_id_idx" ON "pages_blocks_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_stats_path_idx" ON "pages_blocks_stats" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_stats_locales_locale_parent_id_unique" ON "pages_blocks_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_stats_stats_order_idx" ON "pages_blocks_stats_stats" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_stats_stats_parent_id_idx" ON "pages_blocks_stats_stats" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_stats_stats_locales_locale_parent_id_unique" ON "pages_blocks_stats_stats_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_order_idx" ON "pages_blocks_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_parent_id_idx" ON "pages_blocks_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_path_idx" ON "pages_blocks_testimonials" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_testimonials_locales_locale_parent_id_unique" ON "pages_blocks_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_testimonials_order_idx" ON "pages_blocks_testimonials_testimonials" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_testimonials_parent_id_idx" ON "pages_blocks_testimonials_testimonials" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_testimonials_testimonials_author_image_idx" ON "pages_blocks_testimonials_testimonials" USING btree ("author_image_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_testimonials_testimonials_locales_locale_parent" ON "pages_blocks_testimonials_testimonials_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_text_order_idx" ON "pages_blocks_text" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_text_parent_id_idx" ON "pages_blocks_text" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_text_path_idx" ON "pages_blocks_text" USING btree ("_path");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_text_locales_locale_parent_id_unique" ON "pages_blocks_text_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_order_idx" ON "pages_blocks_what_is" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_parent_id_idx" ON "pages_blocks_what_is" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_path_idx" ON "pages_blocks_what_is" USING btree ("_path");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_cards_order_idx" ON "pages_blocks_what_is_cards" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_cards_parent_id_idx" ON "pages_blocks_what_is_cards" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_cards_benefits_order_idx" ON "pages_blocks_what_is_cards_benefits" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "pages_blocks_what_is_cards_benefits_parent_id_idx" ON "pages_blocks_what_is_cards_benefits" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_what_is_cards_benefits_locales_locale_parent_id" ON "pages_blocks_what_is_cards_benefits_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_what_is_cards_locales_locale_parent_id_unique" ON "pages_blocks_what_is_cards_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_blocks_what_is_locales_locale_parent_id_unique" ON "pages_blocks_what_is_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_meta_meta_image_idx" ON "pages_locales" USING btree ("meta_image_id","_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "pages_locales_locale_parent_id_unique" ON "pages_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "pages_rels_order_idx" ON "pages_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "pages_rels_parent_idx" ON "pages_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "pages_rels_path_idx" ON "pages_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "pages_rels_posts_id_idx" ON "pages_rels" USING btree ("posts_id");--> statement-breakpoint
CREATE UNIQUE INDEX "payload_kv_key_idx" ON "payload_kv" USING btree ("key");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_global_slug_idx" ON "payload_locked_documents" USING btree ("global_slug");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_updated_at_idx" ON "payload_locked_documents" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_created_at_idx" ON "payload_locked_documents" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_order_idx" ON "payload_locked_documents_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_parent_idx" ON "payload_locked_documents_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_path_idx" ON "payload_locked_documents_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_users_id_idx" ON "payload_locked_documents_rels" USING btree ("users_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_user_sessions_id_idx" ON "payload_locked_documents_rels" USING btree ("user_sessions_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_user_accounts_id_idx" ON "payload_locked_documents_rels" USING btree ("user_accounts_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_user_verifications_id_idx" ON "payload_locked_documents_rels" USING btree ("user_verifications_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_oauth_application_id_idx" ON "payload_locked_documents_rels" USING btree ("oauth_application_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_oauth_access_token_id_idx" ON "payload_locked_documents_rels" USING btree ("oauth_access_token_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_oauth_consent_id_idx" ON "payload_locked_documents_rels" USING btree ("oauth_consent_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_jwks_id_idx" ON "payload_locked_documents_rels" USING btree ("jwks_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_user_subscriptions_id_idx" ON "payload_locked_documents_rels" USING btree ("user_subscriptions_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_media_id_idx" ON "payload_locked_documents_rels" USING btree ("media_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_categories_id_idx" ON "payload_locked_documents_rels" USING btree ("categories_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_posts_id_idx" ON "payload_locked_documents_rels" USING btree ("posts_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_pages_id_idx" ON "payload_locked_documents_rels" USING btree ("pages_id");--> statement-breakpoint
CREATE INDEX "payload_locked_documents_rels_page_templates_id_idx" ON "payload_locked_documents_rels" USING btree ("page_templates_id");--> statement-breakpoint
CREATE INDEX "payload_migrations_updated_at_idx" ON "payload_migrations" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "payload_migrations_created_at_idx" ON "payload_migrations" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "payload_preferences_key_idx" ON "payload_preferences" USING btree ("key");--> statement-breakpoint
CREATE INDEX "payload_preferences_updated_at_idx" ON "payload_preferences" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "payload_preferences_created_at_idx" ON "payload_preferences" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "payload_preferences_rels_order_idx" ON "payload_preferences_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "payload_preferences_rels_parent_idx" ON "payload_preferences_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "payload_preferences_rels_path_idx" ON "payload_preferences_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "payload_preferences_rels_users_id_idx" ON "payload_preferences_rels" USING btree ("users_id");--> statement-breakpoint
CREATE INDEX "plans_plans_order_idx" ON "plans_plans" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "plans_plans_parent_id_idx" ON "plans_plans" USING btree ("_parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "plans_plans_key_idx" ON "plans_plans" USING btree ("key");--> statement-breakpoint
CREATE INDEX "plans_plans_features_order_idx" ON "plans_plans_features" USING btree ("_order");--> statement-breakpoint
CREATE INDEX "plans_plans_features_parent_id_idx" ON "plans_plans_features" USING btree ("_parent_id");--> statement-breakpoint
CREATE INDEX "plans_plans_features_locale_idx" ON "plans_plans_features" USING btree ("_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "plans_plans_locales_locale_parent_id_unique" ON "plans_plans_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "posts_content_image_content_image_image_idx" ON "posts" USING btree ("content_image_image_id");--> statement-breakpoint
CREATE INDEX "posts_updated_at_idx" ON "posts" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "posts_created_at_idx" ON "posts" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "posts__status_idx" ON "posts" USING btree ("_status");--> statement-breakpoint
CREATE UNIQUE INDEX "posts_slug_idx" ON "posts_locales" USING btree ("slug","_locale");--> statement-breakpoint
CREATE INDEX "posts_meta_meta_image_idx" ON "posts_locales" USING btree ("meta_image_id","_locale");--> statement-breakpoint
CREATE UNIQUE INDEX "posts_locales_locale_parent_id_unique" ON "posts_locales" USING btree ("_locale","_parent_id");--> statement-breakpoint
CREATE INDEX "posts_rels_order_idx" ON "posts_rels" USING btree ("order");--> statement-breakpoint
CREATE INDEX "posts_rels_parent_idx" ON "posts_rels" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "posts_rels_path_idx" ON "posts_rels" USING btree ("path");--> statement-breakpoint
CREATE INDEX "posts_rels_users_id_idx" ON "posts_rels" USING btree ("users_id");--> statement-breakpoint
CREATE INDEX "posts_rels_categories_id_idx" ON "posts_rels" USING btree ("categories_id");--> statement-breakpoint
CREATE INDEX "user_accounts_user_id_idx" ON "user_accounts" USING btree ("user_id_id");--> statement-breakpoint
CREATE INDEX "user_accounts_provider_id_idx" ON "user_accounts" USING btree ("provider_id");--> statement-breakpoint
CREATE INDEX "user_accounts_updated_at_idx" ON "user_accounts" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "user_accounts_created_at_idx" ON "user_accounts" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "user_sessions_user_id_idx" ON "user_sessions" USING btree ("user_id_id");--> statement-breakpoint
CREATE UNIQUE INDEX "user_sessions_token_idx" ON "user_sessions" USING btree ("token");--> statement-breakpoint
CREATE INDEX "user_sessions_ip_address_idx" ON "user_sessions" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "user_sessions_updated_at_idx" ON "user_sessions" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "user_sessions_created_at_idx" ON "user_sessions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "user_subscriptions_user_id_idx" ON "user_subscriptions" USING btree ("user_id_id");--> statement-breakpoint
CREATE INDEX "user_subscriptions_updated_at_idx" ON "user_subscriptions" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "user_subscriptions_created_at_idx" ON "user_subscriptions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "user_verifications_updated_at_idx" ON "user_verifications" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "user_verifications_created_at_idx" ON "user_verifications" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "users_name_idx" ON "users" USING btree ("name");--> statement-breakpoint
CREATE UNIQUE INDEX "users_email_idx" ON "users" USING btree ("email");--> statement-breakpoint
CREATE INDEX "users_updated_at_idx" ON "users" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "users_created_at_idx" ON "users" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "threads_user_id_idx" ON "threads" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "threads_modified_at_idx" ON "threads" USING btree ("modified_at");