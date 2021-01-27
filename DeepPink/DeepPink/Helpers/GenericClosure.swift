//
//  GenericClosure.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import Foundation

typealias EmptyClosure = () -> Void
typealias Closure<T> = (T) -> Void
typealias DClosure<T, A> = (T, A) -> Void
