(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.

;; Describe your resources here

;; The general structure could be described like this:
;;
;; (define-resource <name-used-in-this-file> ()
;;   :class <class-of-resource-in-triplestore>
;;   :properties `((<json-property-name-one> <type-one> ,<triplestore-relation-one>)
;;                 (<json-property-name-two> <type-two> ,<triplestore-relation-two>>))
;;   :has-many `((<name-of-an-object> :via ,<triplestore-relation-to-objects>
;;                                    :as "<json-relation-property>")
;;               (<name-of-an-object> :via ,<triplestore-relation-from-objects>
;;                                    :inverse t ; follow relation in other direction
;;                                    :as "<json-relation-property>"))
;;   :has-one `((<name-of-an-object :via ,<triplestore-relation-to-object>
;;                                  :as "<json-relation-property>")
;;              (<name-of-an-object :via ,<triplestore-relation-from-object>
;;                                  :as "<json-relation-property>"))
;;   :resource-base (s-url "<string-to-which-uuid-will-be-appended-for-uri-of-new-items-in-triplestore>")
;;   :on-path "<url-path-on-which-this-resource-is-available>")


;; An example setup with a catalog, dataset, themes would be:
;;
;; (define-resource catalog ()
;;   :class (s-prefix "dcat:Catalog")
;;   :properties `((:title :string ,(s-prefix "dct:title")))
;;   :has-many `((dataset :via ,(s-prefix "dcat:dataset")
;;                        :as "datasets"))
;;   :resource-base (s-url "http://webcat.tmp.semte.ch/catalogs/")
;;   :on-path "catalogs")

;; (define-resource dataset ()
;;   :class (s-prefix "dcat:Dataset")
;;   :properties `((:title :string ,(s-prefix "dct:title"))
;;                 (:description :string ,(s-prefix "dct:description")))
;;   :has-one `((catalog :via ,(s-prefix "dcat:dataset")
;;                       :inverse t
;;                       :as "catalog"))
;;   :has-many `((theme :via ,(s-prefix "dcat:theme")
;;                      :as "themes"))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/datasets/")
;;   :on-path "datasets")

;; (define-resource distribution ()
;;   :class (s-prefix "dcat:Distribution")
;;   :properties `((:title :string ,(s-prefix "dct:title"))
;;                 (:access-url :url ,(s-prefix "dcat:accessURL")))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/distributions/")
;;   :on-path "distributions")

;; (define-resource theme ()
;;   :class (s-prefix "tfdcat:Theme")
;;   :properties `((:pref-label :string ,(s-prefix "skos:prefLabel")))
;;   :has-many `((dataset :via ,(s-prefix "dcat:theme")
;;                        :inverse t
;;                        :as "datasets"))
;;   :resource-base (s-url "http://webcat.tmp.tenforce.com/themes/")
;;   :on-path "themes")

;;

;; first KISS attempt

(define-resource product ()
  :class (s-prefix "ext:Product")
  :properties `((:name :string ,(s-prefix "ext:name"))
  	            (:unit-price :short-float ,(s-prefix "ext:unitPrice"))
  	            (:description :string ,(s-prefix "ext:description"))
  	            (:type :string ,(s-prefix "ext:type")))
  :has-many `((product-image :via ,(s-prefix "ext:product-image")
                       :as "product-images"))
  :resource-base (s-url "http://datadomain.fabbrikka.com/products/")
  :on-path "products")

(define-resource product-image ()
  :class (s-prefix "ext:ProductImage")
  :properties `((:access-url :url ,(s-prefix "ext:accessURL"))
                (:type :string ,(s-prefix "ext:type")))
  :has-one `((product :via ,(s-prefix "ext:productImage")
                      :inverse t
                      :as "product"))
  :resource-base (s-url "http://datadomain.fabbrikka.com/product-images/")
  :on-path "product-images")



