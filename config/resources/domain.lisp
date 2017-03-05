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


(define-resource shopping-cart ()
  :class (s-prefix "ext:ShoppingCart")
  :properties `((:owner-session :string ,(s-prefix "ext:owner-session")))
  :has-many `((shopping-cart-item :via ,(s-prefix "ext:hasShoppingCartItem")
                    :as "shopping-cart-items"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/shopping-carts/")
  :on-path "shopping-carts")

(define-resource shopping-cart-item ()
  :class (s-prefix "ext:ShoppingCartItem")
  :properties `((:quantity :number ,(s-prefix "ext:quantity")))
  :has-one `((product :via ,(s-prefix "ext:hasProduct")
                      :as "product")
             (shopping-cart :via ,(s-prefix "ext:hasShoppingCartItem")
                       :inverse t
                       :as "shopping-cart")
             (product-size :via ,(s-prefix "ext:hasSize")
                       :as "size"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/shopping-cart-items/")
  :on-path "shopping-cart-items")

(define-resource product-name ()
  :class (s-prefix "ext:ProductName")
  :properties `((:name :string ,(s-prefix "ext:name"))
  	            (:locale :string ,(s-prefix "ext:locale")))
  :has-one `((product :via ,(s-prefix "ext:hasProductName")
  	                :inverse t
                    :as "product"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-names/")
  :on-path "product-names")

(define-resource product-description ()
  :class (s-prefix "ext:ProductDescription")
  :properties `((:description :string ,(s-prefix "ext:description"))
  	            (:locale :string ,(s-prefix "ext:locale")))
  :has-one `((product :via ,(s-prefix "ext:hasProductDescription")
  	                :inverse t
                    :as "product"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-descriptions/")
  :on-path "product-descriptions")

(define-resource product-size ()
  :class (s-prefix "ext:ProductSize")
  :properties `((:size-name :string ,(s-prefix "ext:sizeName")))
  :has-many `((product :via ,(s-prefix "ext:hasProductSize")
  	                :inverse t
                    :as "products"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-sizes/")
  :on-path "product-sizes")

(define-resource product-price ()
  :class (s-prefix "ext:ProductPrice")
  :properties `((:amount :number ,(s-prefix "ext:amount"))
  				(:currency :string, (s-prefix "ext:currency")))
  :has-one `((product :via ,(s-prefix "ext:hasProductPrice")
  	                :inverse t
                    :as "product"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-prices/")
  :on-path "product-prices")

(define-resource product-image ()
  :class (s-prefix "ext:ProductImage")
  :properties `((:access-url :url ,(s-prefix "ext:accessURL"))
                (:type :string ,(s-prefix "ext:type")))
  :has-one `((product :via ,(s-prefix "ext:hasProductImage")
                      :inverse t
                      :as "product"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-images/")
  :on-path "product-images")

(define-resource product-audience ()
  :class (s-prefix "ext:ProductAudience")
  :properties `((:name :string ,(s-prefix "ext:name"))
                (:description :string ,(s-prefix "ext:description"))
                (:label :string ,(s-prefix "ext:label")))
  :has-many `((product :via ,(s-prefix "ext:hasProductAudience")
                    :inverse t
                    :as "products"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/product-audiences/")
  :on-path "product-audiences")

(define-resource product ()
  :class (s-prefix "ext:Product")
  :properties `((:type :string ,(s-prefix "ext:type"))
               (:ranking :int ,(s-prefix "ext:ranking")))
  :has-many `((product-name :via ,(s-prefix "ext:hasProductName")
                     :as "product-names")
              (product-description :via ,(s-prefix "ext:hasProductDescription")
                     :as "product-descriptions")
              (product-size :via ,(s-prefix "ext:hasProductSize")
                     :as "product-sizes")
              (product-image :via ,(s-prefix "ext:hasProductImage")
                       :as "product-images")
              (product-audience :via ,(s-prefix "ext:hasProductAudience")
                    :as "product-audiences"))
  :has-one `((product-price :via ,(s-prefix "ext:hasProductPrice")
                    :as "product-price"))
  :resource-base (s-url "http://business-domain.fabbrikka.com/products/")
  :on-path "products")