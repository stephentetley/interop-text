/*
 * Copyright 2026 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pub mod InteropText.Collator {

    use JavaInterop.AdaptorUnchecked
    use InteropLocale.Locale

    use InteropText.CollationKey

    import java.text.{Collator => JCollator}

    ///
    /// Class / Represents a Collator.
    ///
    /// Consider Collator "Immutable after init" so we can use it 
    /// without a region.
    ///
    pub enum Collator(JCollator)
    
    /// TODO CollatorBuilder

    instance ToJava[Collator] {
        type Out = JCollator
        pub def toJava(x: Collator): JCollator = 
            let Collator.Collator(x1) = x;
            x1
    }

    instance ToFlix[Collator] {
        type In = JCollator
        pub def toFlix(x: JCollator): Collator = 
            Collator.Collator(x)
    }

    pub enum CollatorDecomposition with Eq, Order, ToString {
        case NO_DECOMPOSITION
        case CANONICAL_DECOMPOSITION
        case FULL_DECOMPOSITION
    }

    instance ToJava[CollatorDecomposition] {
        type Out = Int32
        pub def toJava(x: CollatorDecomposition): Int32 = match x {
            case CollatorDecomposition.NO_DECOMPOSITION         => unsafe IO { JCollator.NO_DECOMPOSITION }
            case CollatorDecomposition.CANONICAL_DECOMPOSITION  => unsafe IO { JCollator.CANONICAL_DECOMPOSITION }
            case CollatorDecomposition.FULL_DECOMPOSITION       => unsafe IO { JCollator.FULL_DECOMPOSITION }
        }
    }

    instance ToFlix[CollatorDecomposition] {
        type In = Int32
        pub def toFlix(x: Int32): CollatorDecomposition = unsafe IO {
            if (x.equals(JCollator.NO_DECOMPOSITION))               CollatorDecomposition.NO_DECOMPOSITION
            else if (x.equals(JCollator.CANONICAL_DECOMPOSITION))   CollatorDecomposition.CANONICAL_DECOMPOSITION
            else if (x.equals(JCollator.FULL_DECOMPOSITION))        CollatorDecomposition.FULL_DECOMPOSITION
            else bug!("toFlix[CollatorDecomposition]")
        }
    }


    pub enum CollatorStrength with Eq, Order, ToString {
        case IDENTICAL
        case PRIMARY
        case SECONDARY
        case TERTIARY
    }

    
    instance ToJava[CollatorStrength] {
        type Out = Int32
        pub def toJava(x: CollatorStrength): Int32 = match x {
            case CollatorStrength.IDENTICAL => unsafe IO { JCollator.IDENTICAL }
            case CollatorStrength.PRIMARY   => unsafe IO { JCollator.PRIMARY }
            case CollatorStrength.SECONDARY => unsafe IO { JCollator.SECONDARY }
            case CollatorStrength.TERTIARY  => unsafe IO { JCollator.TERTIARY }
        }
    }

    instance ToFlix[CollatorStrength] {
        type In = Int32
        pub def toFlix(x: Int32): CollatorStrength = unsafe IO {
            if (x.equals(JCollator.IDENTICAL))      CollatorStrength.IDENTICAL
            else if (x.equals(JCollator.PRIMARY))   CollatorStrength.PRIMARY
            else if (x.equals(JCollator.SECONDARY)) CollatorStrength.SECONDARY
            else if (x.equals(JCollator.TERTIARY))  CollatorStrength.TERTIARY
            else bug!("toFlix[CollatorStrength]")
        }
    }



    ///
    /// Get a Collator with the locale of the JVM.
    /// Apply the setters in `fs` to further configure the Collator.
    ///
    pub def getInstance(): Collator \ IO =
        AdaptorUnchecked.of(() -> JCollator.getInstance())
    

    pub def getInstanceWithLocale(loc: Locale): Collator =
        AdaptorUnchecked.op(loc, loc1 -> unsafe IO { JCollator.getInstance(loc1) })



    /// Put collator as first argument for partial application

    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(x: Collator, s1: String, s2: String): Bool =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.equals(s1, s2) })

    ///
    /// Compare strings `s1` and `s2` with the collator `x`.
    ///
    pub def compare(x: Collator, s1: String, s2: String): Comparison =
        AdaptorUnchecked.extract(x, x1 -> 
            unsafe IO { let cmp = x1.compare(s1, s2); Comparison.fromInt32(cmp) }
        )

    pub def getCollationKey(src: String, x: Collator): CollationKey = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getCollationKey(src) })

    pub def getDecomposition(x: Collator): CollatorDecomposition =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getDecomposition() })


    pub def getStrength(x: Collator): CollatorStrength =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getStrength() })


    // Builder?

    // pub def setDecomposition!(mode: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setDecomposition(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setDecomposition(c1, mode)

    // pub def setStrength!(strength: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setStrength(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setStrength(c1, strength)

}

